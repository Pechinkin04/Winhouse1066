//
//  Warehouse.swift
//  Winhouse1066
//
//  Created by Александр Печинкин on 24.11.2024.
//

import Foundation

var mockWarehouses: [Warehouse] = [
    Warehouse(category: mockCaregories[0],
              status: WareStatus.inStock,
              availability: 1200,
              sold: 400,
              revenue: 200200),
    
    Warehouse(category: mockCaregories[1],
              status: WareStatus.forSale,
              availability: 2600,
              sold: 240,
              revenue: 120040),
    
    Warehouse(category: mockCaregories[2],
              status: WareStatus.delivery,
              availability: 4000,
              sold: 0,
              revenue: 0)
]

struct Warehouse: Identifiable, Codable {
    var id = UUID()
    
    var category: Category?
    var status: WareStatus = .inStock
    
    var availability: Int = 0
    var sold: Int = 0
    var revenue: Double = 0
}

enum WareStatus: Identifiable, CaseIterable, Codable {
    case inStock, forSale, delivery, soldOut
    
    var id: Self { self }
    
    var raw: String {
        switch self {
            case .inStock:
                "In stock"
            case .forSale:
                "For sale"
            case .delivery:
                "Delivery"
            case .soldOut:
                "Sold out"
        }
    }
}
