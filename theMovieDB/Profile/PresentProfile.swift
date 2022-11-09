//
//  PresentProfile.swift
//  theMovieDB
//
//  Created by Salma Garcia on 06/11/22.
//

import Foundation

enum ProfileFetchError: Error {
    case failed
}
protocol ProfilePresenterProtocol {
    var router: ProfileRouterProtocol? { get set }
    var interactor: ProfileInteractorProtocol? { get set }
    var view: ProfileViewProtocol? { get set }
    
}

@available(iOS 14.0, *)
class PresenterProfile: ProfilePresenterProtocol{
    
    
    var router: ProfileRouterProtocol?
    var view: ProfileViewProtocol?
    

    var interactor: ProfileInteractorProtocol?    
    
   
}
