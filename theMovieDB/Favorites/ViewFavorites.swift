//
//  ViewFavorites.swift
//  theMovieDB
//
//  Created by Salma Garcia on 08/11/22.
//

import Foundation
import UIKit

protocol FavoritesViewProtocol {
    var presenter: FavoritesPresenterProtocol? { get set }
    var interactor: FavoritesInteractorProtocol? { get set }
    func FavoritesResponse(with result: DetalleMovie)
    func FavoritesResponseError(with error: String)
    
}

@available(iOS 14.0, *)
class FavoritesViewController: UIViewController, FavoritesViewProtocol {


    var presenter: FavoritesPresenterProtocol?
    var interactor: FavoritesInteractorProtocol?
    var router: FavoritesRouterProtocol?
    
   //Label
    private let label: UILabel = {
        let label = UILabel()
        return label
    }()
    
    //StackViewPadre
    private let stackViewVerticalFavorites: UIStackView = {
        let stackViewVerticalMovies = UIStackView()
        stackViewVerticalMovies.translatesAutoresizingMaskIntoConstraints = false
        stackViewVerticalMovies.axis = .vertical
        stackViewVerticalMovies.spacing = 20
        return stackViewVerticalMovies
    }()
    
    //StackViewHijo
    private let stackViewHorizontalFavorites: UIStackView = {
        let stackViewVerticalMovies = UIStackView()
        stackViewVerticalMovies.translatesAutoresizingMaskIntoConstraints = false
        stackViewVerticalMovies.axis = .horizontal
        stackViewVerticalMovies.spacing = 20
        return stackViewVerticalMovies
    }()
    
    //Imagen poster
    private let imagePerfil: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    //Label
     private let labelEmail: UILabel = {
         let label = UILabel()
         return label
     }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(stackViewVerticalFavorites)
        stackViewVerticalFavorites.addArrangedSubview(label)
        stackViewVerticalFavorites.addArrangedSubview(stackViewHorizontalFavorites)
        stackViewHorizontalFavorites.addArrangedSubview(imagePerfil)
        stackViewHorizontalFavorites.addArrangedSubview(labelEmail)
        view.backgroundColor = .systemPink
        confTitleLabel()
        confStackViewVertical()
        confStackViewHorizontal()
        confImage()
        confEmailLabel()
      
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    private func confTitleLabel(){
        label.textColor = .green
        label.text = AppConstant.favorite_text
        label.font = UIFont(name: AppConstant.font_helvetica_bold, size: 30)
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            label.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 20),
            label.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: 20),
            label.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func confImage(){
        imagePerfil.image = UIImage(named: AppConstant.image_profile);
         NSLayoutConstraint.activate([
            imagePerfil.topAnchor.constraint(equalTo: stackViewHorizontalFavorites.layoutMarginsGuide.topAnchor),
            imagePerfil.leadingAnchor.constraint(equalTo: stackViewHorizontalFavorites.layoutMarginsGuide.leadingAnchor),
            imagePerfil.heightAnchor.constraint(equalToConstant: 160),
            imagePerfil.widthAnchor.constraint(equalToConstant: 160)
        ])
        imagePerfil.layer.cornerRadius = imagePerfil.frame.size.height/2
    }
    
    private func confEmailLabel(){
        let email = UserDefaults.standard.string(forKey: defaultKeys.email)
        labelEmail.textColor = .green
        labelEmail.text = email
        labelEmail.font = UIFont(name: AppConstant.font_helvetica_bold, size: 12)
        NSLayoutConstraint.activate([
            labelEmail.topAnchor.constraint(equalTo: stackViewHorizontalFavorites.layoutMarginsGuide.topAnchor, constant: 10),
            labelEmail.leadingAnchor.constraint(equalTo: imagePerfil.layoutMarginsGuide.leadingAnchor, constant: 10),
            labelEmail.trailingAnchor.constraint(equalTo: stackViewVerticalFavorites.layoutMarginsGuide.trailingAnchor),
        ])
    }
    
    
    private func confStackViewVertical(){
        NSLayoutConstraint.activate([
            stackViewVerticalFavorites.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            stackViewVerticalFavorites.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            stackViewVerticalFavorites.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            stackViewVerticalFavorites.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            
        ])
    }
    
    private func confStackViewHorizontal(){
        NSLayoutConstraint.activate([
            stackViewHorizontalFavorites.topAnchor.constraint(equalTo: label.layoutMarginsGuide.bottomAnchor),
            stackViewHorizontalFavorites.leadingAnchor.constraint(equalTo: stackViewVerticalFavorites.leadingAnchor),
            stackViewHorizontalFavorites.trailingAnchor.constraint(equalTo: stackViewVerticalFavorites.layoutMarginsGuide.trailingAnchor, constant: -10),
            stackViewHorizontalFavorites.centerXAnchor.constraint(equalTo: stackViewVerticalFavorites.centerXAnchor)
            
        ])
    }
    
  
  
//    Respuesta success
    func FavoritesResponse(with detalle: DetalleMovie) {
        DispatchQueue.main.async {
        }
    }
    
//    Respuesta error
    func FavoritesResponseError(with error: String) {
        DispatchQueue.main.async {
            self.view.backgroundColor = .red
        }
    }
  
    
}
