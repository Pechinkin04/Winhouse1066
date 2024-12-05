//
//  Category.swift
//  Winhouse1066
//
//  Created by Александр Печинкин on 24.11.2024.
//

import Foundation

var suitsCategory = Category(name: "Suits")

var mockCaregories: [Category] = [
    Category(name: "Sneakers"),
    Category(name: "T-shirts"),
    Category(name: "Socks")
]

struct Category: Identifiable, Codable {
    var id = UUID()
    
    var name: String = ""
}
