//
//  InteractorDetalleMovie.swift
//  theMovieDB
//
//  Created by Salma Garcia on 05/11/22.
//

import Foundation
import FirebaseAuth

protocol DetalleMovieInteractorProtocol {
    var presenter: DetalleMoviePresenterProtocol? { get set }
    var viewLogin: DetalleMovieViewProtocol? { get set }
    func getMovieDetails(id: Int)
    
    
}

class InteractorDetalleMovie: DetalleMovieInteractorProtocol {
   
    
    var viewLogin: DetalleMovieViewProtocol?
    
    var presenter: DetalleMoviePresenterProtocol?
    
    
    func getMovieDetails(id: Int) {
        print("Pidiendo token de solicitud")
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/\(id)?api_key=101c77c5a1d21a36d6a86d4fe9c0ac78&language=en-US") else { return }
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
