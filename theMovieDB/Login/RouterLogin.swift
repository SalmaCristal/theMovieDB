//
//  RouterLogin.swift
//  theMovieDB
//
//  Created by Salma Garcia on 03/11/22.
//

import Foundation
import UIKit


typealias EntryPoint = AnyView & UIViewController

protocol AnyRouter {
    var entry: EntryPoint? { get }
    
    static func start() -> AnyRouter
}

@available(iOS 15.0, *)
class UserRouter: AnyRouter {
    
    var entry: EntryPoint?
    
    static func start() -> AnyRouter {
        let router = UserRouter()
        
        // Assign VIP
        var view: AnyView = LoginViewController()
        var presenter: AnyPresenter = PresenterLogin()
        var interactor: AnyInteractor = InteractorLogin()
        
        view.presenter = presenter
        
        interactor.presenter = presenter
        presenter.router = router
        presenter.viewLogin = view
        presenter.interactor = interactor
        
        router.entry = view as? EntryPoint
        
        return router
    }
}
