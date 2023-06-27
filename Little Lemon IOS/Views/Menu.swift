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
    @State var loaded = false

    var body: some View {
        VStack {
            Header()
            VStack { // Hero Section
                HStack {
                    VStack(alignment: .leading) {
                        Text("Little Lemon").font(.title).foregroundColor(Color.primaryColor2)
                        Text("Chicago").font(.title2).foregroundColor(.white).padding(.bottom)
                        Text("We are a family owned Mediterranean restaurant, focused on traditional recipes served with a modern twist.").fixedSize(horizontal: false, vertical: true).foregroundColor(.white)
                    }
                    Image("Hero-image").resizable().scaledToFit().cornerRadius(14).frame(height: 150)
                }.padding()
                HStack {
                    Image(systemName: "magnifyingglass")
                    TextField("Search menu", text: $searchText)
                }.padding().background(.white)
            }.padding(.bottom, 10).background(Color.primaryColor1)

            FetchedObjects(predicate: buildPredicate(), sortDescriptors: buildSortDescriptors()) { (dishes: [Dish]) in
                List {
                    ForEach(dishes) { dish in
                        FoodItem(dish: dish)
                    }
                }.scrollContentBackground(.hidden)
            }
        }
        .onAppear {
            if !loaded {
                getMenuData()
                loaded = true
            }
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
