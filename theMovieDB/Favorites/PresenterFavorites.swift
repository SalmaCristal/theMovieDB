//
//  PresenterFavorites.swift
//  theMovieDB
//
//  Created by Salma Garcia on 08/11/22.
//

import Foundation

enum FavoritesFetchError: Error {
    case failed
}
protocol FavoritesPresenterProtocol {
    var router: FavoritesRouterProtocol? { get set }
    var interactor: FavoritesInteractorProtocol? { get set }
    var view: FavoritesViewProtocol? { get set }
    
    func interactorDidFetchDetalleMovie(with result: Swift.Result<DetalleMovie, Error>)
}

@available(iOS 14.0, *)
class PresenterFavorites: FavoritesPresenterProtocol{
    
    
    var router: FavoritesRouterProtocol?
    var view: FavoritesViewProtocol?
    

    var interactor: FavoritesInteractorProtocol? 
    func interactorDidFetchDetalleMovie(with result: Swift.Result<DetalleMovie, Error>) {
        switch result {
        case .success(let response):
            view?.FavoritesResponse(with: response)
        case .failure(let error):
            view?.FavoritesResponseError(with: error.localizedDescription)
        }
    }
    
   
}
