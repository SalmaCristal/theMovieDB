//
//  RouterProfile.swift
//  theMovieDB
//
//  Created by Salma Garcia on 06/11/22.
//

import Foundation
import UIKit


typealias ProfileEntryPoint = ProfileViewProtocol & UIViewController

protocol ProfileRouterProtocol {
    var entry: ProfileEntryPoint? { get }
    
    static func start() -> ProfileRouterProtocol
}

@available(iOS 14.0, *)
class ProfileRouter: ProfileRouterProtocol {
    
    var entry: ProfileEntryPoint?
    
    static func start() -> ProfileRouterProtocol {
        let router = ProfileRouter()
        
        // Assign VIP
        var view: ProfileViewProtocol = ProfileViewController()
        var presenter: ProfilePresenterProtocol = PresenterProfile()
        var interactor: ProfileInteractorProtocol = InteractorProfile()
        
        view.presenter = presenter
        
        interactor.presenter = presenter
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        
        router.entry = view as? ProfileEntryPoint
        
        return router
    }
}
