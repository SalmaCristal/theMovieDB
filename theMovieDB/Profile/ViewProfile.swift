//
//  ViewProfile.swift
//  theMovieDB
//
//  Created by Salma Garcia on 06/11/22.
//

import Foundation
import UIKit

protocol ProfileViewProtocol {
    var presenter: ProfilePresenterProtocol? { get set }
    var interactor: ProfileInteractorProtocol? { get set }
    func profileResponse(with result: DetalleMovie)
    func profileResponseError(with error: String)
    
}

@available(iOS 14.0, *)
class ProfileViewController: UIViewController, ProfileViewProtocol {


    var presenter: ProfilePresenterProtocol?
    var interactor: ProfileInteractorProtocol?
    var router: ProfileRouterProtocol?
    
   //Label
    private let label: UILabel = {
        let label = UILabel()
        return label
    }()
    
    //StackViewPadre
    private let stackViewVerticalProfile: UIStackView = {
        let stackViewVerticalMovies = UIStackView()
        stackViewVerticalMovies.translatesAutoresizingMaskIntoConstraints = false
        stackViewVerticalMovies.axis = .vertical
        stackViewVerticalMovies.spacing = 20
        return stackViewVerticalMovies
    }()
    
    //StackViewHijo
    private let stackViewHorizontalProfile: UIStackView = {
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
        view.addSubview(stackViewVerticalProfile)
        stackViewVerticalProfile.addArrangedSubview(label)
        stackViewVerticalProfile.addArrangedSubview(stackViewHorizontalProfile)
        stackViewHorizontalProfile.addArrangedSubview(imagePerfil)
        stackViewHorizontalProfile.addArrangedSubview(labelEmail)
        view.backgroundColor = .black
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
        label.text = "Profile"
        label.font = UIFont(name: "Helvetica Neue Bold", size: 30)
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            label.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 20),
            label.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: 20),
            label.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func confImage(){
        imagePerfil.image = UIImage(named: "profileA");
         NSLayoutConstraint.activate([
            imagePerfil.topAnchor.constraint(equalTo: stackViewHorizontalProfile.layoutMarginsGuide.topAnchor),
            imagePerfil.leadingAnchor.constraint(equalTo: stackViewHorizontalProfile.layoutMarginsGuide.leadingAnchor),
            imagePerfil.heightAnchor.constraint(equalToConstant: 160),
            imagePerfil.widthAnchor.constraint(equalToConstant: 160)
        ])
        imagePerfil.layer.cornerRadius = imagePerfil.frame.size.height/2
    }
    
    private func confEmailLabel(){
        labelEmail.textColor = .green
        labelEmail.text = "salma@gmail.com"
        labelEmail.font = UIFont(name: "Helvetica Neue Bold", size: 12)
        NSLayoutConstraint.activate([
            labelEmail.topAnchor.constraint(equalTo: stackViewHorizontalProfile.layoutMarginsGuide.topAnchor, constant: 10),
            labelEmail.leadingAnchor.constraint(equalTo: imagePerfil.layoutMarginsGuide.leadingAnchor, constant: 10),
            labelEmail.trailingAnchor.constraint(equalTo: stackViewVerticalProfile.layoutMarginsGuide.trailingAnchor),
        ])
    }
    
    
    private func confStackViewVertical(){
        NSLayoutConstraint.activate([
            stackViewVerticalProfile.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            stackViewVerticalProfile.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            stackViewVerticalProfile.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            stackViewVerticalProfile.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            
        ])
    }
    
    private func confStackViewHorizontal(){
        NSLayoutConstraint.activate([
            stackViewHorizontalProfile.topAnchor.constraint(equalTo: label.layoutMarginsGuide.bottomAnchor),
            stackViewHorizontalProfile.leadingAnchor.constraint(equalTo: stackViewVerticalProfile.leadingAnchor),
            stackViewHorizontalProfile.trailingAnchor.constraint(equalTo: stackViewVerticalProfile.layoutMarginsGuide.trailingAnchor, constant: -10),
            stackViewHorizontalProfile.centerXAnchor.constraint(equalTo: stackViewVerticalProfile.centerXAnchor)
            
        ])
    }
    
  
  
//    Respuesta success
    func profileResponse(with detalle: DetalleMovie) {
        print("EXITO DETALLE \(detalle.title)")
        
        DispatchQueue.main.async {
        }
    }
    
//    Respuesta error
    func profileResponseError(with error: String) {
        print("FAILED DETALLE \(error)")
        DispatchQueue.main.async {
            self.view.backgroundColor = .red
        }
    }
  
    
}
