//
//  WinVM.swift
//  Winhouse1066
//
//  Created by Александр Печинкин on 24.11.2024.
//

import Foundation
import SwiftUI

class WinVM: ObservableObject {
    @Published var categories: [Category]
    @Published var warehouses: [Warehouse]
    @Published var goods: [Good]
    
    var availabilityTotal: Int { warehouses.reduce(0, { $0 + $1.availability }) }
    var soldTotal: Int { warehouses.reduce(0, { $0 + $1.sold }) }
    var revenueTotal: Double { warehouses.reduce(0, { $0 + $1.revenue }) }
    
    private var itemTotal: Int { availabilityTotal + soldTotal }
    
    var stockPart: Double {
        Double(warehouses.reduce(0, { $0 + ($1.status == .inStock ? $1.availability + $1.sold : 0 ) })) / Double(itemTotal == 0 ? 1 : itemTotal)
    }
    var forSalePart: Double {
        Double(warehouses.reduce(0, { $0 + ($1.status == .forSale ? $1.availability + $1.sold : 0 ) })) / Double(itemTotal == 0 ? 1 : itemTotal)
    }
    var deliveryPart: Double {
        Double(warehouses.reduce(0, { $0 + ($1.status == .delivery ? $1.availability + $1.sold : 0 ) })) / Double(itemTotal == 0 ? 1 : itemTotal)
    }
    var soldOutPart: Double {
        guard itemTotal > 0 else { return 0 }
        return 1 - (stockPart + forSalePart + deliveryPart)
    }
    
    init() {
//        categories = mockCaregories
//        warehouses = mockWarehouses
//        goods = mockGoods
        
        categories = UserDefaults.standard.getCategory(forKey: "categoriesWinHouseStorage")
        warehouses = UserDefaults.standard.getArray(forKey: "warehousesWinHouseStorage")
        goods = UserDefaults.standard.getArray(forKey: "goodsWinHouseStorage")
    }
    
    public func addElem<T: Identifiable>(_ elem: T, to: inout [T]) {
        to.insert(elem, at: 0)
    }
    
    public func editElem<T: Identifiable>(_ elem: T, to: inout [T]) {
        guard let indElem = findInd(elem, from: to) else { return }
        to[indElem] = elem
    }
    
    public func removeElem<T: Identifiable>(_ elem: T, to: inout [T]) {
        guard let indElem = findInd(elem, from: to) else { return }
        to.remove(at: indElem)
    }
    
    private func findInd<T: Identifiable>(_ elem: T, from: [T]) -> Int? {
        from.firstIndex(where: { $0.id == elem.id })
    }
    
    public func saveCategories() { UserDefaults.standard.setArray(categories, forKey: "categoriesWinHouseStorage") }
    public func saveWarehouses() { UserDefaults.standard.setArray(warehouses, forKey: "warehousesWinHouseStorage") }
    public func saveGoods() { UserDefaults.standard.setArray(goods, forKey: "goodsWinHouseStorage") }
}
