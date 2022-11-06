//
//  InteractorMovies.swift
//  theMovieDB
//
//  Created by Salma Garcia on 04/11/22.
//

import Foundation


protocol AnyInteractorMovies {
    var presenter: AnyPresenterMovies? { get set }
    
    func getUsers()
    
}

class MoviesInteractor: AnyInteractorMovies {
    var presenter: AnyPresenterMovies?
    
    func getUsers() {
        print("Start fetching")
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=101c77c5a1d21a36d6a86d4fe9c0ac78&language=en-US&page=1") else { return }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                self?.presenter?.interactorDidFetchMovies(with: .failure(FetchErrorMovies.failed))
                return
            }
            
            do {
                let entities = try JSONDecoder().decode(Popular.self, from: data)
                
                print("ENTITIES \(entities)   DATA \(data)")
                self?.presenter?.interactorDidFetchMovies(with: .success(entities))
            }
            catch {
                self?.presenter?.interactorDidFetchMovies(with: .failure(error))
            }
        }
        task.resume()
    }
}
