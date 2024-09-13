//
//  NetworkManager.swift
//  ProductViper
//
//  Created by Okan on 6.09.2024.
//

import Foundation

protocol NetworkServiceProtocol {
    func request<T: Decodable>(request: NetworkRequest) async throws -> T
}

final class NetworkManager: NetworkServiceProtocol {
    private let sessionManager: NetworkSessionManagerProtocol
    
    init(sessionManager: NetworkSessionManagerProtocol) {
        self.sessionManager = sessionManager
    }
    
    func request<T: Decodable>(request: NetworkRequest) async throws -> T {
        let (data, response) = try await sessionManager.request(with: request)
        guard let response = response as? HTTPURLResponse else { throw NetworkError.noResponse }
        guard response.statusCode == 200 else { throw NetworkError.failed }
        guard let data else { throw NetworkError.noData }
        if let jsonString = String(data: data, encoding: .utf8) {
            //                    print(jsonString)
        }
        return try decode(data)
    }
    
    
    private func decode<T: Decodable>(_ data: Data) throws -> T {
        do {
            let decodedData = try JSONDecoder().decode(T.self, from: data)
            return decodedData
        } catch {
            throw NetworkError.decode
        }
    }
}


extension Encodable {
    func prettyPrintedJSONString() -> String? {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        guard let data = try? encoder.encode(self) else { return nil }
        return String(data: data, encoding: .utf8) ?? nil
        
    }
}
