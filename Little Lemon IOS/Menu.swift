//
//  Menu.swift
//  Little Lemon IOS
//
//  Created by Aaron Wells on 6/26/23.
//

import SwiftUI

struct Menu: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State var searchText = ""

    var body: some View {
        VStack {
            VStack { // Hero Section
                HStack {
                    VStack(alignment: .leading) {
                        Text("Little Lemon").font(.title).foregroundColor(.yellow)
                        Text("Chicago").font(.title2).foregroundColor(.white).padding(.bottom)
                        Text("We are a family owned Mediterranean restaurant, focused on traditional recipes served with a modern twist.").fixedSize(horizontal: false, vertical: true).foregroundColor(.white)
                    }
                    Image("Hero-image").resizable().scaledToFit().cornerRadius(14).frame(height: 150)
                }.padding()
                HStack {
                    Image(systemName: "magnifyingglass")
                    TextField("Search menu", text: $searchText)
                }.padding().background(.white)
            }.padding(.bottom, 10).background(.green)

            // FILTER OPTIONS
            VStack {
                Text("Order for Delivery").font(.title3).frame(maxWidth: .infinity, alignment: .leading).padding()
                HStack {
                    Text("Starters").font(.subheadline).padding()
                        .background(.gray)
                        .clipShape(Capsule())
                    Text("Mains").font(.subheadline).padding()
                        .background(.gray)
                        .clipShape(Capsule())
                    Text("Desserts").font(.subheadline).padding()
                        .background(.gray)
                        .clipShape(Capsule())
                    Text("Sides").font(.subheadline).padding()
                        .background(.gray)
                        .clipShape(Capsule())
                }.frame(maxWidth: .infinity)
                Spacer().frame(maxWidth: .infinity, maxHeight: 2).background(.gray).padding()
            }.frame(maxWidth: .infinity, alignment: .leading)

            FetchedObjects(predicate: buildPredicate(), sortDescriptors: buildSortDescriptors()) { (dishes: [Dish]) in
                List {
                    ForEach(dishes) { dish in
                        HStack {
                            VStack {
                                Text(dish.title!)
                                Text(dish.dishDescription!)
                                Text("$\(dish.price!)")
                            }
                            AsyncImage(url: URL(string: dish.image!)) { phase in
                                phase.image?.resizable().scaledToFit()
                            }.frame(width: 60, height: 60)
                        }
                    }
                }.scrollContentBackground(.hidden)
            }
        }
        .onAppear {
            getMenuData()
        }
    }

    func getMenuData() {
        PersistenceController.shared.clear()
        let url = URL(string: "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json")

        let request = URLRequest(url: url!)
        let task = URLSession.shared.dataTask(with: request) { data, _, _ in
            if let data = data {
                let decoder = JSONDecoder()
                let menu = try? decoder.decode(MenuList.self, from: data)
                menu?.menu.forEach { item in
                    let newDish = Dish(context: viewContext)
                    newDish.title = item.title
                    newDish.dishDescription = item.description
                    newDish.price = item.price
                    newDish.image = item.image
                    newDish.category = item.category
                }
                try? viewContext.save()
            }
        }
        task.resume()
    }

    func buildSortDescriptors() -> [NSSortDescriptor] {
        return [
            NSSortDescriptor(key: "title", ascending: true, selector: #selector(NSString.localizedCaseInsensitiveCompare))
        ]
    }

    func buildPredicate() -> NSPredicate {
        if searchText.isEmpty {
            return NSPredicate(value: true)
        } else {
            return NSPredicate(format: "title CONTAINS[cd] %@", searchText)
        }
    }
}

struct Menu_Previews: PreviewProvider {
    static var previews: some View {
        Menu()
    }
}
