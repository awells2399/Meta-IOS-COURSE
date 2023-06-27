//
//  FilterOptions.swift
//  Little Lemon IOS
//
//  Created by Aaron Wells on 6/27/23.
//

import SwiftUI

struct FilterOptions: View {
    var body: some View {
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
    }
}

struct FilterOptions_Previews: PreviewProvider {
    static var previews: some View {
        FilterOptions()
    }
}
