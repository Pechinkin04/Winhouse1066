//
//  Extensions.swift
//  Winhouse1066
//
//  Created by Александр Печинкин on 24.11.2024.
//

import Foundation
import SwiftUI

extension Date {
    func toStringDays(format: String = "dd.MM.yyyy") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    
    func toStringHours(format: String = "HH:mm") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}

let amountFormatter: NumberFormatter = {
    let formatter = NumberFormatter()
    formatter.zeroSymbol = ""
    formatter.numberStyle = .decimal
    formatter.allowsFloats = false // Разрешить ввод дробей
    formatter.maximumFractionDigits = 0 // Максимальное количество знаков после запятой
    return formatter
}()

let amountFormatterDouble: NumberFormatter = {
    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    formatter.zeroSymbol = ""
    formatter.allowsFloats = true // Разрешить ввод дробей
    formatter.maximumFractionDigits = 2 // Максимальное количество знаков после запятой
    return formatter
}()

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

public func hideKeyboard() {
    UIApplication.shared.endEditing()
}

extension UserDefaults {
    func getArray<T: Codable>(forKey key: String)  -> [T] {
        if let data = data(forKey: key), let array = try? JSONDecoder().decode([T].self, from: data) {
            return array
        }
        return []
    }
    
    func setArray<T: Codable>(_ array: [T], forKey key: String) {
        if let encoded = try? JSONEncoder().encode(array) {
            set(encoded, forKey: key)
        }
    }
    
    func getCategory(forKey key: String)  -> [Category] {
        if let data = data(forKey: key), let category = try? JSONDecoder().decode([Category].self, from: data) {
            return category
        }
        return [suitsCategory]
    }
    
    func setCategory(_ category: [Category], forKey key: String) {
        if let encoded = try? JSONEncoder().encode(category) {
            set(encoded, forKey: key)
        }
    }
}
