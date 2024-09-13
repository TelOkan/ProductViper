//
//  Double+Extensions.swift
//  ProductViper
//
//  Created by Okan on 13.09.2024.
//

import Foundation
extension Double {
    func toCurrency() -> String? {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "en_US")
        return formatter.string(from: NSNumber(value: self))
    }
}
