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
}

