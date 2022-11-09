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
}

class InteractorProfile: ProfileInteractorProtocol {
    var viewLogin: ProfileViewProtocol?
    var presenter: ProfilePresenterProtocol?
    
}
