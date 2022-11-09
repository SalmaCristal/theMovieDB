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
    func getMovieDetails(id: Int, tipo:String)
    func getVideos(id: Int, tipo:String)
}

class InteractorDetalleMovie: DetalleMovieInteractorProtocol {
    var viewLogin: DetalleMovieViewProtocol?
    var presenter: DetalleMoviePresenterProtocol?
    
    let HOST = AppConstant.HOST
    let API_KEY = AppConstant.API_KEY
    let LANG = AppConstant.LANG
    
    func getMovieDetails(id: Int, tipo: String) {
      
        let urlHost = HOST + tipo + String(id) + API_KEY + LANG
        guard let url = URL(string:urlHost) else { return }
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
    
    func getVideos(id: Int, tipo:String) {
        
        let urlHost = HOST + tipo + String(id) + AppConstant.video + API_KEY + LANG
        guard let url = URL(string:urlHost) else { return }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                self?.presenter?.interactorDidFetchVideos(with: .failure(FetchError.failed))
                return
            }
            do {
                let entities = try JSONDecoder().decode(DetalleVideo.self, from: data)
                self?.presenter?.interactorDidFetchVideos(with: .success(entities))
            }
            catch {
                self?.presenter?.interactorDidFetchVideos(with: .failure(error))
            }
        }
        task.resume()
    }
}
