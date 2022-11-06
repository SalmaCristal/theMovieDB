//
//  InteractorLogin.swift
//  theMovieDB
//
//  Created by Salma Garcia on 03/11/22.
//

import Foundation
import FirebaseAuth

protocol AnyInteractor {
    var presenter: AnyPresenter? { get set }
    var viewLogin: AnyView? { get set }
    
    func login(username: String, password: String)
    
}

class InteractorLogin: AnyInteractor {
    var viewLogin: AnyView?
    
    var presenter: AnyPresenter?
    
    func login(username: String, password: String) {
        if (username != "" && password != "") {
            Auth.auth().createUser(withEmail: username, password: password) { (result, error) in
                if let result = result, error == nil {
                    self.presenter?.interactorDidFetchLogin(with: .success(result.user.email!))
                    
                } else {
                    self.presenter?.interactorDidFetchLogin(with: .failure(error!))
                }
            }
        } 
    }
    
   
    
    func getUsers() {
//        print("Pidiendo token de solicitud")
//        guard let url = URL(string: "https://api.themoviedb.org/3/movie/550?api_key=101c77c5a1d21a36d6a86d4fe9c0ac78") else { return }
//        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
//            guard let data = data, error == nil else {
//                self?.presenter?.interactorDidFetchUsers(with: .failure(FetchError.failed))
//                return
//            }
//
//            do {
//                let entities = try JSONDecoder().decode([User].self, from: data)
//                self?.presenter?.interactorDidFetchUsers(with: .success(entities))
//            }
//            catch {
//                self?.presenter?.interactorDidFetchUsers(with: .failure(error))
//            }
//        }
//        task.resume()
    }
}
