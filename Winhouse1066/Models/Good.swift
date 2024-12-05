//
//  Good.swift
//  Winhouse1066
//
//  Created by Александр Печинкин on 24.11.2024.
//

import Foundation

var mockGoods: [Good] = [
    Good(category: mockCaregories[1],
         name: "T-White",
         brand: "Nezer",
         country: "Germany",
         code: 01001,
         price: 45),
    
    Good(category: mockCaregories[1],
         name: "T-Black",
         brand: "Nezer",
         country: "Germany",
         code: 01002,
         price: 37),
    
    Good(category: mockCaregories[1],
         name: "T-Gradient",
         brand: "Nezer",
         country: "Germany",
         code: 01003,
         price: 55)
]

struct Good: Identifiable, Codable {
    var id = UUID()
    
    var category: Category?
    var img: String?
    
    var name: String = ""
    var brand: String = ""
    var country: String = ""
    var code: Int = 0
    var price: Double = 0
}
