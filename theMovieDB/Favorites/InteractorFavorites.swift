//
//  InteractorFavorites.swift
//  theMovieDB
//
//  Created by Salma Garcia on 08/11/22.
//

import Foundation
import FirebaseAuth

protocol FavoritesInteractorProtocol {
    var presenter: FavoritesPresenterProtocol? { get set }
    var viewLogin: FavoritesViewProtocol? { get set }
    func createFavorites(idSeleccionado: Int)
    func deleteFavorites(arrayMoviesComplete: Array<ResultMovies>) 
}

class InteractorFavorites: FavoritesInteractorProtocol {

    
    var viewLogin: FavoritesViewProtocol?
    var presenter: FavoritesPresenterProtocol?
    
    let defaults = UserDefaults.standard
    private let manager = CoreDataManager()
    var counter = 0
    
    func createFavorites(idSeleccionado: Int) {
        let id = String(idSeleccionado)
        let uidUser = defaults.string(forKey: defaultKeys.uid)
        manager.createFavorite(showSeleccionado: id, uid_user: uidUser!) { [weak self] in
            self?.updateUI()
        }
    }
    
    func deleteFavorites(arrayMoviesComplete: Array<ResultMovies>) {
        let arrayFavorites = defaults.array(forKey: defaultKeys.arrayFavorites)
        let indexTouch = defaults.integer(forKey: defaultKeys.indexTouch)
        manager.deleteFavorites(arrayMovies: arrayFavorites! as! Array<ResultMovies>)
        
    }
    
    
    func updateUI() {
        counter = counter + 1
        let favorites = manager.getFavorites()
        
    }
    
}
