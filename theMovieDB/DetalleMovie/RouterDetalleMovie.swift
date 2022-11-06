//
//  RouterDetalleMovie.swift
//  theMovieDB
//
//  Created by Salma Garcia on 05/11/22.
//

import Foundation
import UIKit


typealias DetalleMovieEntryPoint = DetalleMovieViewProtocol & UIViewController

protocol DetalleMovieRouterProtocol {
    var entry: DetalleMovieEntryPoint? { get }
    
    static func start() -> DetalleMovieRouterProtocol
}

@available(iOS 14.0, *)
class DetalleMovieRouter: DetalleMovieRouterProtocol {
    
    var entry: DetalleMovieEntryPoint?
    
    static func start() -> DetalleMovieRouterProtocol {
        let router = DetalleMovieRouter()
        
        // Assign VIP
        var view: DetalleMovieViewProtocol = DetalleMovieViewController()
        var presenter: DetalleMoviePresenterProtocol = PresenterDetalleMovie()
        var interactor: DetalleMovieInteractorProtocol = InteractorDetalleMovie()
        
        view.presenter = presenter
        
        interactor.presenter = presenter
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        
        router.entry = view as? DetalleMovieEntryPoint
        
        return router
    }
}
