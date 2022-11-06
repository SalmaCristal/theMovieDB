//
//  InteractorMovies.swift
//  theMovieDB
//
//  Created by Salma Garcia on 04/11/22.
//

import Foundation

enum categoryName: String {
    case Popular = "popular"
    case TopRated = "top_rated"
    case OnTV = "on_the_air"
    case AiringToday = "airing_today"
}
enum showsType : String {
    case TV = "tv"
    case Movie = "movie"
}

protocol AnyInteractorMovies {
    var presenter: AnyPresenterMovies? { get set }
    
    func getMovies(category: Int)
    
}

class MoviesInteractor: AnyInteractorMovies {
    var presenter: AnyPresenterMovies?
    
    func getMovies(category: Int) {
        var movieCategory = ""
        var showsKind = ""
        switch category {
        case 0:
            movieCategory = categoryName.Popular.rawValue
            showsKind = showsType.Movie.rawValue
            break
        case 1:
            movieCategory = categoryName.TopRated.rawValue
            showsKind = showsType.Movie.rawValue
            break
        case 2:
            movieCategory = categoryName.OnTV.rawValue
            showsKind = showsType.TV.rawValue
            break
        case 3:
            movieCategory = categoryName.AiringToday.rawValue
            showsKind = showsType.TV.rawValue
            break
        default:
            movieCategory = categoryName.Popular.rawValue
            showsKind = showsType.Movie.rawValue
        }
        print("Start fetching")
        guard let url = URL(string: "https://api.themoviedb.org/3/\(showsKind)/\(movieCategory)?api_key=101c77c5a1d21a36d6a86d4fe9c0ac78&language=es-ES") else { return }
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
