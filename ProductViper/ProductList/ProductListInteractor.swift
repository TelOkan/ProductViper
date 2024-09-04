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

protocol AnyInteractor: AnyObject {
    associatedtype P

    var refPresenter: (any AnyPresenter)? { get set }
}

extension AnyInteractor {
    var presenter: P? {
        refPresenter?.castTo(P.self)
    }
}

protocol ProductListInteractorInput: AnyInteractor {
//    typealias T = ProductListPresenter

    func getProducts()
}

//extension ProductListInteractorInput {
//    var currentPresenter: T? {
//        presenter?.castTo(T.self)
//    }
//}


struct ProductsModel: Codable {
    let products: [Product]
}

class ProductListInteractor: ProductListInteractorInput {
    typealias P = ProductListPresenterInput
    
    weak var refPresenter: (any AnyPresenter)?
    
    func getProducts() {
        guard let url = URL(string: "https://dummyjson.com/products") else { return }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let self else { return }
            guard let data = data, error == nil else {
                return
            }
            
            
            do {
                let productModel = try JSONDecoder().decode(ProductsModel.self, from: data)
                presenter?.interactorDidFetchProducts(with: .success(productModel.products))
            } catch {
                presenter?.interactorDidFetchProducts(with: .failure(error))
            }
        }
        
        task.resume()
    }
}


extension AnyPresenter {
    func castTo<T>(_ type: T.Type) -> T? {
        return self as? T
    }
}

extension AnyRouter {
    func castTo<T>(_ type: T.Type) -> T? {
        return self as? T
    }
}

extension AnyView {
    func castTo<T>(_ type: T.Type) -> T? {
        return self as? T
    }
}

extension AnyInteractor {
    func castTo<T>(_ type: T.Type) -> T? {
        return self as? T
    }
}
