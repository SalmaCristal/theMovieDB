//
//  InteractorProfile.swift
//  theMovieDB
//
//  Created by Salma Garcia on 06/11/22.
//

import Foundation
import FirebaseAuth

protocol ProfileInteractorProtocol {
    var presenter: ProfilePresenterProtocol? { get set }
    var viewLogin: ProfileViewProtocol? { get set }
    func getMovieDetails(id: Int)
}

class InteractorProfile: ProfileInteractorProtocol {
    var viewLogin: ProfileViewProtocol?
    var presenter: ProfilePresenterProtocol?
    
    
    func getMovieDetails(id: Int) {
        let HOST = AppConstant.HOST
        let API_KEY = AppConstant.API_KEY
        let LANG = AppConstant.LANG
        
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/\(id)?api_key=101c77c5a1d21a36d6a86d4fe9c0ac78&language=es-ES") else { return }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                self?.presenter?.interactorDidFetchDetalleMovie(with: .failure(FetchError.failed))
                return
            }
            do {
                let entities = try JSONDecoder().decode(DetalleMovie.self, from: data)
                self?.presenter?.interactorDidFetchDetalleMovie(with: .success(entities))
            }
            catch {
                self?.presenter?.interactorDidFetchDetalleMovie(with: .failure(error))
            }
        }
        task.resume()
    }
}
