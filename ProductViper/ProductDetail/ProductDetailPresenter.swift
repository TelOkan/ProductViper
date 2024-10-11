//
//  ProductDetailPresenter.swift
//  ProductViper
//
//  Created by Okan on 11.10.2024.
//

import Foundation
protocol ProductDetailPresenterProtocol {
    var interactor: ProductDetailInteractorInput? { get set }
    var router: ProductDetailRouterProtocol? { get set }
    var view: ProductDetailViewOutputProtocol? { get set }
}

protocol ProductDetailPresenterInput {
    func viewDidload()
}

protocol ProductDetailPresenterOutput {
    func didFetchProduct(with result: Result<Product, Error>)
}

class ProductDetailPresenter: ProductDetailPresenterProtocol {
    var interactor: ProductDetailInteractorInput?
    var router: ProductDetailRouterProtocol?
    var view: ProductDetailViewOutputProtocol?
    private let id: Int
    
    init(
        interactor: ProductDetailInteractorInput?,
        router: ProductDetailRouterProtocol?,
        view: ProductDetailViewOutputProtocol?,
        id: Int
    ) {
        self.interactor = interactor
        self.router = router
        self.view = view
        self.id = id
    }
}

extension ProductDetailPresenter: ProductDetailPresenterInput {
    func viewDidload() {
        Task { [weak self] in
            guard let self else { return }
            try await interactor?.fetchProduct(with: id)
        }
    }
}

extension ProductDetailPresenter: ProductDetailPresenterOutput {
    func didFetchProduct(with result: Result<Product, Error>) {
        switch result {
        case .success(let product):
            view?.handleOutput(with: .update(product))
        case .failure(let error):
            view?.handleOutput(with: .error(error))
        }
    }
}
