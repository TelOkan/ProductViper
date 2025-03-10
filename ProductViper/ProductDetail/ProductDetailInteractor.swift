//
//  ProductDetailInteractor.swift
//  ProductViper
//
//  Created by Okan on 11.10.2024.
//

import Foundation
protocol ProductDetailInteractorProtocol {
    var presenter: ProductDetailPresenterOutput? { get set }
    var networkManager: any NetworkServiceProtocol { get set }
}

protocol ProductDetailInteractorInput: AnyObject, ProductDetailInteractorProtocol {
    func fetchProduct(with id: Int) async throws
}

class ProductDetailInteractor: ProductDetailInteractorInput {
    weak var presenter: ProductDetailPresenterOutput?
    var networkManager: any NetworkServiceProtocol
    
    init(
        presenter: ProductDetailPresenterOutput? = nil,
        networkManager: any NetworkServiceProtocol
    ) {
        self.presenter = presenter
        self.networkManager = networkManager
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
