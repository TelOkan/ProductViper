//
//  ProductListPresenter.swift
//  ProductViper
//
//  Created by Okan on 2.09.2024.
//

import Foundation
// object
// protocol
// reference interactor, router, view.

protocol ProductListPresenterProtocol: AnyObject {
    var interactor: ProductListInteractorInput? { get set }
    var router: ProductListRouterProtocol? { get set }
    var view: ProductListViewOutputProtocol? { get set }
}

protocol ProductListPresenterInput {
    func viewDidload()
    func didSelectRow(with id: Int)
}

protocol ProductListPresenterOutput {
    func didFetchProducts(with result: Result<[Product], Error>)
    func didFetchProduct(with result: Result<Product, Error>)
}

class ProductListPresenter: ProductListPresenterProtocol {
    var interactor: ProductListInteractorInput?
    var router: ProductListRouterProtocol?
    var view: ProductListViewOutputProtocol?
    
    init(
        interactor: ProductListInteractorInput?,
        router: ProductListRouterProtocol?,
        view: ProductListViewOutputProtocol?
    ) {
        self.interactor = interactor
        self.router = router
        self.view = view
    }
}


//MARK: - ProductListPresenterInput
extension ProductListPresenter: ProductListPresenterInput {
    func viewDidload() {
        Task { [weak self] in
            guard let self else { return }
            try await interactor?.fetchProducts()
        }
    }
    
    func didSelectRow(with id: Int) {
        Task { [weak self] in
            guard let self else { return }
            try await interactor?.fetchProduct(with: id)
        }
    }
}


//MARK: - ProductListPresenterOutput
extension ProductListPresenter: ProductListPresenterOutput {
    func didFetchProducts(with result: Result<[Product], Error>) {
        switch result {
        case .success(let products):
            view?.handleOutput(with: .update(products))
        case .failure(let error):
            view?.handleOutput(with: .error(error))
        }
    }
    
    func didFetchProduct(with result: Result<Product, Error>) {
        switch result {
        case .success(let product):
            print("Product: ", product)
        case .failure(let error):
            print("error: ", error.localizedDescription)
        }
    }
}
