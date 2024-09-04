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
}

protocol ProductListInteractorInput: ProductListInteractorProtocol {
    func fetchProducts()
}



class ProductListInteractor: ProductListInteractorInput {
    var presenter: ProductListPresenterOutput?
    
    func fetchProducts() {
        guard let url = URL(string: "https://dummyjson.com/products") else { return }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let self else { return }
            guard let data = data, error == nil else {
                return
            }
            
            
            do {
                let products = try JSONDecoder().decode(ProductsModel.self, from: data).products
                presenter?.didFetchProducts(with: .success(products))
            } catch {
                presenter?.didFetchProducts(with: .failure(error))
            }
        }
        
        task.resume()
    }
}
