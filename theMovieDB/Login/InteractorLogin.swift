//
//  InteractorLogin.swift
//  theMovieDB
//
//  Created by Salma Garcia on 03/11/22.
//

import Foundation

protocol AnyInteractor {
    var presenter: AnyPresenter? { get set }
    
    func getUsers()
    
}

class UserInteractor: AnyInteractor {
    var presenter: AnyPresenter?
    
    func getUsers() {
        print("Pidiendo token de solicitud")
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/550?api_key=101c77c5a1d21a36d6a86d4fe9c0ac78") else { return }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                self?.presenter?.interactorDidFetchUsers(with: .failure(FetchError.failed))
                return
            }
            
            do {
                let entities = try JSONDecoder().decode([User].self, from: data)
                self?.presenter?.interactorDidFetchUsers(with: .success(entities))
            }
            catch {
                self?.presenter?.interactorDidFetchUsers(with: .failure(error))
            }
        }
        task.resume()
    }
}
