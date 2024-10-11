//
//  ProductDetailEntity.swift
//  ProductViper
//
//  Created by Okan on 11.10.2024.
//

import Foundation

enum ProductDetailViewOutput {
    case update(_ product: Product)
    case error(_ error: Error)
}
