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
    func interactorDidFetchVideos(with result: Swift.Result<DetalleVideo, Error>)
}

@available(iOS 14.0, *)
class PresenterDetalleMovie: DetalleMoviePresenterProtocol{
    
    
    var router: DetalleMovieRouterProtocol?
    var view: DetalleMovieViewProtocol?
    

    var interactor: DetalleMovieInteractorProtocol? {
        didSet {
            let defaults = UserDefaults.standard
            let idOfMovie = defaults.integer(forKey: defaultKeys.id_movie)
            let showsTypes = defaults.string(forKey: defaultKeys.is_tv_or_movie)
            interactor?.getMovieDetails(id: idOfMovie, tipo: showsTypes ?? showsType.Movie.rawValue)
            interactor?.getVideos(id: idOfMovie, tipo: showsTypes ?? showsType.Movie.rawValue)
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
    
    func interactorDidFetchVideos(with result: Swift.Result<DetalleVideo, Error>) {
        switch result {
        case .success(let response):
            view?.videoResponse(with: response)
        case .failure(let error):
            view?.videoResponseError(with: error.localizedDescription)
        }
    }
        
        
}
