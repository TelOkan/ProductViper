//
//  NetworkSessionManager.swift
//  ProductViper
//
//  Created by Okan on 6.09.2024.
//

import Foundation

protocol NetworkSessionManagerProtocol {
    func request(with config: NetworkConfigurable, from request: NetworkRequest) async throws -> (Data?, URLResponse?)
}

final class DefaulNetworkSessionManager: NetworkSessionManagerProtocol {
    private let session: URLSession
    private let requestGenerator: URLRequestGeneratorProtocol
    
    init(
        session: URLSession = URLSession.shared,
        requestGenerator: URLRequestGeneratorProtocol = DefaultURLRequestGenerator()
    ) {
        self.session = session
        self.requestGenerator = requestGenerator
    }
    
    
    func request(with config: NetworkConfigurable, from request: NetworkRequest) async throws -> (Data?, URLResponse?) {
        let urlRequest = try requestGenerator.generateURL(with: config, from: request)
        
        do {
            return try await session.data(for: urlRequest)
        } catch {
            throw NetworkError.resolve(with: error)
        }
    }
}
