//
//  NetworkConfigurable.swift
//  ProductViper
//
//  Created by Okan on 6.09.2024.
//

import Foundation

protocol NetworkConfigurable {
    var baseURL: String { get }
    var headers: [String: String] { get }
}

class DefaultNetworkConfig: NetworkConfigurable {
    var baseURL: String
    var headers: [String : String]
    
    init(
        baseURL: String,
        headers: [String : String] = [:]
    ) {
        self.baseURL = baseURL
        self.headers = headers
    }
}
