//
//  Constants.swift
//  ProductViper
//
//  Created by Okan on 11.10.2024.
//

import Foundation

struct AppConstants {
    static let baseURL = "dummyjson.com"
    static let scheme = "https"
    static let contentType: [String: String] = ["Content-Type": "application/json"]
}

struct APIEndpoints {
    static let products = "/products"
    static let product = "/products/"
}
