//
//  NetworkRequest.swift
//  ProductViper
//
//  Created by Okan on 6.09.2024.
//

import Foundation

protocol NetworkRequestable {
    var path: String { get set }
    var method: HTTPMethod { get set }
    var headerParameters: [String: String] { get set }
    var queryParameters: [String: Any] { get set }
    var bodyParameters: [String: Any] { get set }
}

struct NetworkRequest: NetworkRequestable {
    var path: String
    var method: HTTPMethod
    var headerParameters: [String : String]
    var queryParameters: [String : Any]
    var bodyParameters: [String : Any]
    
    init(
        path: String,
        method: HTTPMethod,
        headerParameters: [String : String] = [:],
        queryParameters: [String : Any]  = [:],
        bodyParameters: [String : Any]  = [:]
    ) {
        self.path = path
        self.method = method
        self.headerParameters = headerParameters
        self.queryParameters = queryParameters
        self.bodyParameters = bodyParameters
    }
}
