//
//  PresenterLogin.swift
//  theMovieDB
//
//  Created by Salma Garcia on 03/11/22.
//

import Foundation

enum FetchError: Error {
    case failed
}
protocol AnyPresenter {
    var router: AnyRouter? { get set }
    var interactor: AnyInteractor? { get set }
    var viewLogin: AnyView? { get set }
    
    func interactorDidFetchLogin(with result: Result<String, Error>)
}

class PresenterLogin: AnyPresenter {
    
    var router: AnyRouter?
    var viewLogin: AnyView?
   
    var interactor: AnyInteractor? {
        didSet {
            interactor?.login(username: "", password: "")
        }
    }
    
    
    
    func interactorDidFetchLogin(with result: Result<String, Error>) {
        switch result {
        case .success(let response):
            viewLogin?.loginResponse(with: response)
        case .failure(let error):
            viewLogin?.loginResponseError(with: error.localizedDescription)
        }
    }
    
    
    
}
