//
//  PresenterDetalleMovie.swift
//  theMovieDB
//
//  Created by Salma Garcia on 05/11/22.
//

import Foundation

enum DetalleMovieFetchError: Error {
    case failed
}
protocol DetalleMoviePresenterProtocol {
    var router: DetalleMovieRouterProtocol? { get set }
    var interactor: DetalleMovieInteractorProtocol? { get set }
    var view: DetalleMovieViewProtocol? { get set }
    
    func interactorDidFetchDetalleMovie(with result: Swift.Result<DetalleMovie, Error>)
}

@available(iOS 14.0, *)
class PresenterDetalleMovie: DetalleMoviePresenterProtocol{
    
    
    var router: DetalleMovieRouterProtocol?
    var view: DetalleMovieViewProtocol?
    

    var interactor: DetalleMovieInteractorProtocol? {
        didSet {
            let defaults = UserDefaults.standard
            let idOfMovie = defaults.integer(forKey: defaultKeys.id_movie)
            interactor?.getMovieDetails(id: idOfMovie)
        }
        
    }
    func interactorDidFetchDetalleMovie(with result: Swift.Result<DetalleMovie, Error>) {
        switch result {
        case .success(let response):
            view?.detalleMovieResponse(with: response)
        case .failure(let error):
            view?.detalleMovieResponseError(with: error.localizedDescription)
        }
    }
    
   
}
