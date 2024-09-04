//
//  ProductListRouter.swift
//  ProductViper
//
//  Created by Okan on 2.09.2024.
//

import Foundation
import UIKit

// Object
// Entery point
// screens starts from here.

typealias EntryPoint = AnyView & UIViewController

protocol AnyRouter {
    var entry: EntryPoint? { get }

    static func start() -> AnyRouter
}

class ProductListRouter: AnyRouter {
    var entry: EntryPoint?
    
    static func start() -> any AnyRouter {
        let router = ProductListRouter()
        
        var view: AnyView = ProductListViewController()
        let interactor: any AnyInteractor = ProductListInteractor()
        var presenter: any AnyPresenter = ProductListPresenter()
        
        
        view.presenter = presenter
        interactor.refPresenter = presenter
        
        presenter.refRouter = router
        presenter.refView = view
        presenter.refInteractor = interactor
        
        router.entry = view as? EntryPoint
        
        return router
    }
}
