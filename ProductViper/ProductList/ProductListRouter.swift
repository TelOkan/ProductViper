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

protocol ProductListRouterProtocol {
    var entryView: UIViewController? { get }

    static func start() -> ProductListRouterProtocol
}

class ProductListRouter: ProductListRouterProtocol {
    var entryView: UIViewController?
    
    static func start() -> any ProductListRouterProtocol {
        let router = ProductListRouter()
        
        let view = ProductListViewController()
        
        let networkManager = NetworkManager(
            config: DefaultNetworkConfig(baseURL: AppConstants.baseURL),
            sessionManager: DefaulNetworkSessionManager()
        )
        
        let interactor = ProductListInteractor(networkManager: networkManager)
        
        let presenter = ProductListPresenter(
            interactor: interactor,
            router: router,
            view: view
        )
        
        view.presenter = presenter
        interactor.presenter = presenter
        
        router.entryView = view
        
        return router
    }
}
