//
//  ProductListEntity.swift
//  ProductViper
//
//  Created by Okan on 2.09.2024.
//

import Foundation

// Model

struct Product: Codable {
    var id: Int?
    var title: String?
    var description: String?
    var category: String?
    var image: String?
    var price: Double?
}
