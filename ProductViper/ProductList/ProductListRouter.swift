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
    
    func routeToDetail(with id: Int)
}

class ProductListRouter: ProductListRouterProtocol {
    var entryView: UIViewController?
    
    static func start() -> any ProductListRouterProtocol {
        let router = ProductListRouter()
        
        let view = ProductListViewController()
        
        let networkManager = NetworkManager(
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
    
    func routeToDetail(with id: Int) {
           let router = ProductDetaiRouter()
           let view = ProductDetailView()
           let networkManager: NetworkManager = .init(sessionManager: DefaulNetworkSessionManager())
   
           let interactor = ProductDetailInteractor(networkManager: networkManager)
   
           let presenter = ProductDetailPresenter(
               interactor: interactor,
               router: router,
               view: view,
               id: id
           )
   
           view.presenter = presenter
           interactor.presenter = presenter
   
           guard let entryView else { return }
           entryView.navigationController?.pushViewController(view, animated: true)
    }
}
