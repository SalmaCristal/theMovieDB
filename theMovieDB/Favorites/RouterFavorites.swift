//
//  RouterFavorites.swift
//  theMovieDB
//
//  Created by Salma Garcia on 08/11/22.
//

import Foundation
import UIKit


typealias FavoritesEntryPoint = FavoritesViewProtocol & UIViewController

protocol FavoritesRouterProtocol {
    var entry: FavoritesEntryPoint? { get }
    
    static func start() -> FavoritesRouterProtocol
}

@available(iOS 14.0, *)
class FavoritesRouter: FavoritesRouterProtocol {
    
    var entry: FavoritesEntryPoint?
    
    static func start() -> FavoritesRouterProtocol {
        let router = FavoritesRouter()
        
        // Assign VIP
        var view: FavoritesViewProtocol = FavoritesViewController()
        var presenter: FavoritesPresenterProtocol = PresenterFavorites()
        var interactor: FavoritesInteractorProtocol = InteractorFavorites()
        
        view.presenter = presenter
        
        interactor.presenter = presenter
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        
        router.entry = view as? FavoritesEntryPoint
        
        return router
    }
}
