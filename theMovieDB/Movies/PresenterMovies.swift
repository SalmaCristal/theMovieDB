//
//  PresenterMovies.swift
//  theMovieDB
//
//  Created by Salma Garcia on 04/11/22.
//

import Foundation

enum FetchErrorMovies: Error {
    case failed
}
protocol AnyPresenterMovies {
    var router: AnyRouterMovies? { get set }
    var interactor: AnyInteractorMovies? { get set }
    var view: AnyViewMovies? { get set }
    
    func interactorDidFetchMovies(with result: Swift.Result<Popular, Error>)
    func interactorSignOutSuccess()
    func interactorSignOutError()
}

class MoviesPresenter: AnyPresenterMovies {
    var router: AnyRouterMovies?
    let tipoVista = UserDefaults.standard.integer(forKey: defaultKeys.segmento)
    var interactor: AnyInteractorMovies? {
        
        didSet {
            interactor?.getMovies(category: tipoVista)
            
        }
    }
    
    var view: AnyViewMovies?
    
    func interactorDidFetchMovies(with result: Swift.Result<Popular, Error>) {
        switch result {
        case .success(let popular):
            view?.update(with: popular)
        case .failure:
            view?.update(with: AppConstant.errorMessage)
        }
    }
    
    func interactorSignOutSuccess(){
        view?.signOutSuccesss()
    }
    func interactorSignOutError(){
        view?.signOutError(errorMessage: AppConstant.errorMessage)
    }
}
