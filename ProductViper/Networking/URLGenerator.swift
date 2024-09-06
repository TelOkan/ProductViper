//
//  URLGenerator.swift
//  ProductViper
//
//  Created by Okan on 6.09.2024.
//

import Foundation

protocol URLRequestGeneratorProtocol {
    func generateURL(from request: NetworkRequest) throws -> URLRequest
}

final class DefaultURLRequestGenerator: URLRequestGeneratorProtocol {
    func generateURL(from request: NetworkRequest) throws -> URLRequest {
        let url = try createURL(from: request)
        var urlRequest = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 15)
        urlRequest.httpMethod = request.method.rawValue
        
        if request.bodyParameters.isNotEmpty {
            do {
                let bodyData = try JSONSerialization.data(
                    withJSONObject: request.bodyParameters,
                    options: [.prettyPrinted]
                )
                
                urlRequest.httpBody = bodyData
            } catch {
                throw NetworkError.bodyParamater
            }
        }
        
        request.headerParameters.forEach { key, value in
            urlRequest.setValue(value, forHTTPHeaderField: key)
        }
        
        return urlRequest
    }
    
    
    private func createURL(from request: NetworkRequest) throws -> URL {
        var components = URLComponents()
        components.scheme = request.scheme
        components.host = request.host
        components.path = request.path
        components.queryItems = request.queryParameters.map { URLQueryItem(name: $0, value: "\($1)") }
        guard let url = components.url else { throw NetworkError.badURL }
        return url
    }
}
