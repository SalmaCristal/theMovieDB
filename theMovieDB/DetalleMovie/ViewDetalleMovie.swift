//
//  ViewDetalleMovie.swift
//  theMovieDB
//
//  Created by Salma Garcia on 05/11/22.
//

import Foundation
import UIKit

protocol DetalleMovieViewProtocol {
    var presenter: DetalleMoviePresenterProtocol? { get set }
    var interactor: DetalleMovieInteractorProtocol? { get set }
    func detalleMovieResponse(with result: DetalleMovie)
    func detalleMovieResponseError(with error: String)
    
}

@available(iOS 14.0, *)
class DetalleMovieViewController: UIViewController, DetalleMovieViewProtocol {

    var presenter: DetalleMoviePresenterProtocol?
    var interactor: DetalleMovieInteractorProtocol?
    var router: DetalleMovieRouterProtocol?
    var arrayDetalles:[DetalleMovie]?
   
    //StackViewGeneral
    private let stackViewVertical: UIStackView = {
        let stackViewVertical = UIStackView()
        stackViewVertical.translatesAutoresizingMaskIntoConstraints = false
        stackViewVertical.axis = .vertical
        stackViewVertical.spacing = 20
        return stackViewVertical
    }()
    
    //Label
    private let titleMovieLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.isHidden = true
        return label
    }()
    
    //Imagen poster
    private let imageBackgroud: UIImageView = {
        let imageLogo = UIImageView()
        imageLogo.translatesAutoresizingMaskIntoConstraints = false
        return imageLogo
    }()
    
    //StackViewPrimerSegmentoTexto
    private let StackViewPrimerSegmentoTexto: UIStackView = {
        let stackViewVertical = UIStackView()
        stackViewVertical.translatesAutoresizingMaskIntoConstraints = false
        stackViewVertical.axis = .vertical
        stackViewVertical.spacing = 20
        return stackViewVertical
    }()
    
    //StackViewTimeAndForAdult
    private let StackViewTimeAndForAdult: UIStackView = {
        let stackViewHorizontal = UIStackView()
        stackViewHorizontal.translatesAutoresizingMaskIntoConstraints = false
        stackViewHorizontal.axis = .vertical
        stackViewHorizontal.spacing = 20
        return stackViewHorizontal
    }()
    
    
    //Boton Favorite
    private let favButton: UIButton = {
        let favButton = UIButton(type: .system)
        if #available(iOS 15.0, *) {
            var configuration = UIButton.Configuration.filled()
            configuration.image = UIImage(named: "heart")
            favButton.translatesAutoresizingMaskIntoConstraints = false
            favButton.configuration = configuration
            
            return favButton
        } else {
            // Fallback on earlier versions
            favButton.setTitle("Log in", for: UIControl.State.highlighted)
            return favButton
        }
        
    }()
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        view.addSubview(stackViewVertical)
        view.addSubview(titleMovieLabel)
        stackViewVertical.addArrangedSubview(imageBackgroud)
        confStackView()
//        stackViewVertical.addArrangedSubview(userNameTextField)
//        stackViewVertical.addArrangedSubview(passwordTextField)
//        stackViewVertical.addArrangedSubview(accederButton)
//        stackViewVertical.addArrangedSubview(label)
//        accederButton.addTarget(self, action: #selector(loginButonListener), for: .touchUpInside)
      
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
//        confEditText()
//        confBotonAcceder()
    }
    
    private func confTitleMovieLabel(){
        titleMovieLabel.textColor = .white
        titleMovieLabel.font = UIFont(name: "Futura Bold", size: 20)
        NSLayoutConstraint.activate([
            titleMovieLabel.bottomAnchor.constraint(equalTo: imageBackgroud.bottomAnchor),
            titleMovieLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            titleMovieLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func confImage(path: String) {
        let url = URL(string: "https://image.tmdb.org/t/p/original/\(path)")
        
       
        DispatchQueue.main.async { [self] in
            imageBackgroud.loader(url: url!)
            imageBackgroud.contentMode = .scaleAspectFill
            NSLayoutConstraint.activate([
                imageBackgroud.topAnchor.constraint(equalTo: stackViewVertical.topAnchor, constant: 0),
                imageBackgroud.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
                imageBackgroud.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
                imageBackgroud.heightAnchor.constraint(equalToConstant: 300)
            ])
            
        }
       
    }
    
    private func confStackView(){
        NSLayoutConstraint.activate([
            stackViewVertical.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            stackViewVertical.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            stackViewVertical.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            stackViewVertical.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            
        ])
    }
    
    
    
    // MARK: - Boton seleccionado
    @objc private func loginButonListener(){

       
    }
    
    
//    Respuesta success
    func detalleMovieResponse(with detalle: DetalleMovie) {
        print("EXITO DETALLE \(detalle.title)")
        if let path = detalle.backdropPath {
            confImage(path: path)
        }
        
        
    }
    
//    Respuesta error
    func detalleMovieResponseError(with error: String) {
        print("FAILED DETALLE \(error)")
        DispatchQueue.main.async {
            self.view.backgroundColor = .red
        }
    }
    
    
  
    
}
