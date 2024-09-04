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

protocol AnyPresenter: AnyObject {
    associatedtype R
    associatedtype I
    associatedtype V
    
    var refRouter: AnyRouter? { get set }
    var refInteractor: (any AnyInteractor)? { get set }
    var refView: AnyView? { get set }
}

extension AnyPresenter {
    var router: R? {
        refRouter?.castTo(R.self)
    }
    
    var interactor: I? {
        refInteractor?.castTo(I.self)
    }
    
    var view: V? {
        refView?.castTo(V.self)
    }
}

protocol ProductListPresenterInput: AnyPresenter {
    func interactorDidFetchProducts(with result: Result<[Product], Error>)
}

class ProductListPresenter: ProductListPresenterInput {
    typealias R = ProductListRouter
    typealias I = ProductListInteractor
    typealias V = ProductListViewController

    var refInteractor: (any AnyInteractor)? {
        didSet {
            interactor?.getProducts()
        }
    }
    var refRouter: AnyRouter?
    var refView: AnyView?
}

//MARK: - ProductListPresenterInput

extension ProductListPresenter {
    func interactorDidFetchProducts(with result: Result<[Product], Error>) {
        switch result {
        case .success(let success):
            print("success!")
        case .failure(let failure):
            print("error:", failure.localizedDescription)
        }
    }
}
