//
//  HeroSection.swift
//  Little Lemon IOS
//
//  Created by Aaron Wells on 6/26/23.
//

import SwiftUI

struct HeroSection: View {
    @State var searchText = ""
    var body: some View {
        VStack { // Hero Section
            HStack {
                VStack {
                    Text("Little Lemon").font(.largeTitle).foregroundColor(.yellow)
                    Text("Chicago").font(.title2).foregroundColor(.white)
                    Text("We are a family owned restaurant, focused on traditional recipes served with a modern twist").foregroundColor(.white)
                }.frame(maxHeight: .infinity, alignment: .topLeading)
                Image("Hero-image").resizable().scaledToFit().cornerRadius(14)
            }
            HStack {
                Image(systemName: "magnifyingglass")
                TextField("Search menu", text: $searchText)
            }.padding().background(.white)
            Spacer()
        }.background(.green).frame(maxWidth: .infinity)
    }
}

struct HeroSection_Previews: PreviewProvider {
    static var previews: some View {
        HeroSection()
    }
}
