//
//  InteractorLogin.swift
//  theMovieDB
//
//  Created by Salma Garcia on 03/11/22.
//

import Foundation
import FirebaseAuth
import SVProgressHUD

protocol AnyInteractor {
    var presenter: AnyPresenter? { get set }
    var viewLogin: AnyView? { get set }
    
    func login(username: String, password: String)
    
}

class InteractorLogin: AnyInteractor {
    var viewLogin: AnyView?
    
    var presenter: AnyPresenter?
    
    func login(username: String, password: String) {
        
        let defaults = UserDefaults.standard
        if (username != "" && password != "") {
            Auth.auth().signIn(withEmail: username.lowercased(), password: password) { (result, error) in
               
                if let result = result, error == nil {
                    self.presenter?.interactorDidFetchLogin(with: .success(result.user.email!))
                    defaults.set(result.user.email, forKey: defaultKeys.email)
                    defaults.set(result.user.uid, forKey: defaultKeys.uid)
                    defaults.synchronize()
                } else {
                    self.presenter?.interactorDidFetchLogin(with: .failure(error!))
                }
            }
        } 
    }
}
