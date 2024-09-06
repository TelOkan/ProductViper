//
//  NetworkError.swift
//  ProductViper
//
//  Created by Okan on 6.09.2024.
//

import Foundation

enum NetworkError: Error {
    case badURL
    case badHostname
    case failed
    case noResponse
    case noData
    case decode
    case internetConnection
    case bodyParamater
    case unknown
    
    
    
    static func resolve(with error: Error) -> NetworkError {
        let code = URLError.Code(rawValue: (error as NSError).code)
        switch code {
        case .notConnectedToInternet:
            return .internetConnection
        case .cannotFindHost:
            return .badHostname
        default:
            return .unknown
        }
    }
}
