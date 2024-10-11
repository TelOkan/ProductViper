//
//  ProductListEntity.swift
//  ProductViper
//
//  Created by Okan on 2.09.2024.
//

import Foundation

// Model

struct ProductsModel: Codable {
    let products: [Product]
}

struct Product: Codable {
    var id: Int?
    var title: String?
    var description: String?
    var category: String?
    var images: [String]?
    var price: Double?
}

enum ProductListViewOutput {
    case update(_ products: [Product])
    case error(_ error: Error)
}
