//
//  PresentProfile.swift
//  theMovieDB
//
//  Created by Salma Garcia on 06/11/22.
//

import Foundation

enum ProfileFetchError: Error {
    case failed
}
protocol ProfilePresenterProtocol {
    var router: ProfileRouterProtocol? { get set }
    var interactor: ProfileInteractorProtocol? { get set }
    var view: ProfileViewProtocol? { get set }
    
    func interactorDidFetchDetalleMovie(with result: Swift.Result<DetalleMovie, Error>)
}

@available(iOS 14.0, *)
class PresenterProfile: ProfilePresenterProtocol{
    
    
    var router: ProfileRouterProtocol?
    var view: ProfileViewProtocol?
    

    var interactor: ProfileInteractorProtocol? {
        didSet {
//            let defaults = UserDefaults.standard
//            let idOfMovie = defaults.integer(forKey: defaultKeys.id_movie)
//            interactor?.getMovieDetails(id: idOfMovie)
        }
        
    }
    func interactorDidFetchDetalleMovie(with result: Swift.Result<DetalleMovie, Error>) {
        switch result {
        case .success(let response):
            view?.profileResponse(with: response)
        case .failure(let error):
            view?.profileResponseError(with: error.localizedDescription)
        }
    }
    
   
}
