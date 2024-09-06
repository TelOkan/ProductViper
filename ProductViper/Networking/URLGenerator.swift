//
//  URLGenerator.swift
//  ProductViper
//
//  Created by Okan on 6.09.2024.
//

import Foundation

protocol URLRequestGeneratorProtocol {
    func generateURL(with config: NetworkConfigurable, from request: NetworkRequest) throws -> URLRequest
}

final class DefaultURLRequestGenerator: URLRequestGeneratorProtocol {
    func generateURL(with config: NetworkConfigurable, from request: NetworkRequest) throws -> URLRequest {
        let url = try createURL(with: config, from: request)
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
        
        config.headers.forEach { key, value in
            urlRequest.setValue(value, forHTTPHeaderField: key)
        }
        
        return urlRequest
    }
    
    
    private func createURL(with config: NetworkConfigurable, from request: NetworkRequest) throws -> URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = config.baseURL
        components.path = request.path
        components.queryItems = request.queryParameters.map { URLQueryItem(name: $0, value: "\($1)") }
        guard let url = components.url else { throw NetworkError.badURL }
        return url
    }
}
