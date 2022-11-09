//
//  InteractorMovies.swift
//  theMovieDB
//
//  Created by Salma Garcia on 04/11/22.
//

import Foundation
import FirebaseAuth
import FirebaseCore
import SVProgressHUD

protocol AnyInteractorMovies {
    var presenter: AnyPresenterMovies? { get set }
    
    func getMovies(category: Int)
    func cerrarSession()
    
}

class MoviesInteractor: AnyInteractorMovies {
    var presenter: AnyPresenterMovies?
    let HOST = AppConstant.HOST
    let API_KEY = AppConstant.API_KEY
    let LANG = AppConstant.LANG
    
    func getMovies(category: Int) {
        let categoryAndShow = Utilities().getCategoryAndShowType(category: category)
        let movieCategory = categoryAndShow.0
        let showsKind = categoryAndShow.1
        SVProgressHUD.show(withStatus: AppConstant.cargando)
        let urlHost = HOST + showsKind + movieCategory + API_KEY + LANG
        guard let url = URL(string: urlHost) else { return }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                self?.presenter?.interactorDidFetchMovies(with: .failure(FetchErrorMovies.failed))
                return
            }
            do {
                let entities = try JSONDecoder().decode(Popular.self, from: data)
                self?.presenter?.interactorDidFetchMovies(with: .success(entities))
            }
            catch {
                self?.presenter?.interactorDidFetchMovies(with: .failure(error))
            }
            SVProgressHUD.dismiss()
        }
        task.resume()
    }
    
    func cerrarSession() {
        do {
            try Auth.auth().signOut()
            let defaults = UserDefaults.standard
            defaults.removeObject(forKey: defaultKeys.email)
            defaults.synchronize()
            self.presenter?.interactorSignOutSuccess()
            
        } catch {
            self.presenter?.interactorSignOutError()
        }
    }
    
   
    
}

