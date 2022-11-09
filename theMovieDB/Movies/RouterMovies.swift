//
//  RouterMovies.swift
//  theMovieDB
//
//  Created by Salma Garcia on 04/11/22.
//

import Foundation
import UIKit


typealias EntryPointMovies = AnyViewMovies & UIViewController

protocol AnyRouterMovies {
    var entry: EntryPointMovies? { get }
    
    static func start() -> AnyRouterMovies
}

@available(iOS 14.0, *)
class MoviesRouter: AnyRouterMovies {
    
    var entry: EntryPointMovies?
    
    static func start() -> AnyRouterMovies {
        let router = MoviesRouter()
        
        // Assign VIP
        var view: AnyViewMovies = MoviesViewController()
        var presenter: AnyPresenterMovies = MoviesPresenter()
        var interactor: AnyInteractorMovies = MoviesInteractor()
        
        view.presenter = presenter
        interactor.presenter = presenter
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        router.entry = view as? EntryPointMovies
        return router
    }
}
