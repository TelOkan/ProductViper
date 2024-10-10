//
//  ProductListInteractor.swift
//  ProductViper
//
//  Created by Okan on 2.09.2024.
//

import Foundation

// object
// protocol
// reference presenter

protocol ProductListInteractorProtocol: AnyObject {
    var presenter: ProductListPresenterOutput? { get set }
    var networkManager: any NetworkServiceProtocol { get set }
}

protocol ProductListInteractorInput: ProductListInteractorProtocol {
    func fetchProducts() async throws
    func fetchProduct(with id: Int) async throws
}

struct AppConstants {
    static let baseURL = "dummyjson.com"
    static let scheme = "https"
    static let contentType: [String: String] = ["Content-Type": "application/json"]
}

struct APIEndpoints {
    static let products = "/products"
    static let product = "/products/"
}

class ProductListInteractor: ProductListInteractorInput {
    var presenter: ProductListPresenterOutput?
    var networkManager: any NetworkServiceProtocol
    
    init(
        presenter: ProductListPresenterOutput? = nil,
        networkManager: any NetworkServiceProtocol
    ) {
        self.presenter = presenter
        self.networkManager = networkManager
    }
    
    func fetchProducts() async throws {
        do {
            let request = NetworkRequest(path: APIEndpoints.products, method: .get)
            let productList: ProductsModel = try await networkManager.request(request: request)
            
            presenter?.didFetchProducts(with: .success(productList.products))
        } catch {
            presenter?.didFetchProducts(with: .failure(error))
        }
    }
    
    func fetchProduct(with id: Int) async throws {
        do {
            let path = APIEndpoints.product + id.description
            let request = NetworkRequest(path: path, method: .get)
            let product: Product = try await networkManager.request(request: request)
            
            presenter?.didFetchProduct(with: .success(product))
        } catch {
            presenter?.didFetchProduct(with: .failure(error))
        }
    }
}

