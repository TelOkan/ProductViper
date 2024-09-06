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
    var scheme: String
    var host: String
    var path: String
    var method: HTTPMethod
    var headerParameters: [String : String]
    var queryParameters: [String : Any]
    var bodyParameters: [String : Any]
    
    init(
        scheme: String = AppConstants.scheme,
        host: String = AppConstants.baseURL,
        path: String,
        method: HTTPMethod,
        headerParameters: [String : String] = ["Content-Type": "application/json"],
        queryParameters: [String : Any]  = [:],
        bodyParameters: [String : Any]  = [:]
    ) {
        self.scheme = scheme
        self.host = host
        self.path = path
        self.method = method
        self.headerParameters = headerParameters
        self.queryParameters = queryParameters
        self.bodyParameters = bodyParameters
    }
}
