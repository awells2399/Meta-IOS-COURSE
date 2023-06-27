//
//  MenuItem.swift
//  Little Lemon IOS
//
//  Created by Aaron Wells on 6/26/23.
//

import Foundation

struct MenuItem: Decodable {
    let title: String
    let image: String
    let price: String
    let description: String
    let category: String
}
