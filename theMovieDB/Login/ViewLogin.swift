//
//  ViewLogin.swift
//  theMovieDB
//
//  Created by Salma Garcia on 03/11/22.
//

import Foundation
import UIKit

protocol AnyView {
    var presenter: AnyPresenter? { get set }
    
    func update(with users: [User])
    func update(with error: String)
}

@available(iOS 15.0, *)
class UserViewController: UIViewController, AnyView {
    
    var presenter: AnyPresenter?
    
    private let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.isHidden = true
        return label
    }()
    
    //Username
    private let userNameTextField: UITextField = {
        let userNameTextField = UITextField()
        userNameTextField.textColor = .black
        return userNameTextField
    }()
    
    //Password
    private let passwordTextField: UITextField = {
        let passwordTextField = UITextField()
        passwordTextField.textColor = .black
        passwordTextField.isSecureTextEntry = true
        return passwordTextField
    }()
    
    
    private let accederButton: UIButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.title = "Log in"
        
        let accederButton = UIButton(type: .system)
        accederButton.translatesAutoresizingMaskIntoConstraints = false
        accederButton.configuration = configuration
        
        return accederButton
    }()
    
    //Imagen logo
    private let imageLogo: UIImageView = {
        let imageLogo = UIImageView()
        imageLogo.image = UIImage(named: "logo")
        imageLogo.translatesAutoresizingMaskIntoConstraints = false
        return imageLogo
    }()
    
    //StackView
    private let stackViewVertical: UIStackView = {
        let stackViewVertical = UIStackView()
        stackViewVertical.translatesAutoresizingMaskIntoConstraints = false
        stackViewVertical.axis = .vertical
        stackViewVertical.spacing = 20
        return stackViewVertical
    }()
    
    
    var users: [User] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .purple
        view.addSubview(imageLogo)
        view.addSubview(stackViewVertical)
        confStackView()
        confImage()
        stackViewVertical.addArrangedSubview(userNameTextField)
        stackViewVertical.addArrangedSubview(passwordTextField)
        stackViewVertical.addArrangedSubview(accederButton)
        
    }
    
    private func confImage(){
        NSLayoutConstraint.activate([ // 5
                    imageLogo.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                    imageLogo.bottomAnchor.constraint(equalTo: stackViewVertical.layoutMarginsGuide.topAnchor),
                    imageLogo.heightAnchor.constraint(equalToConstant: 150),
                    imageLogo.widthAnchor.constraint(equalToConstant: 150),
                ])
    }
    
    private func confStackView(){
        NSLayoutConstraint.activate([
                   stackViewVertical.topAnchor.constraint(equalTo: imageLogo.bottomAnchor, constant: 20),
                   stackViewVertical.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
                   stackViewVertical.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
                   stackViewVertical.centerYAnchor.constraint(equalTo: view.centerYAnchor)
                   
               ])
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
//        label.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
//        label.center = view.center
        confEditText()
        confBotonAcceder()
    }
    
    private func confEditText(){
        userNameTextField.backgroundColor = .white
        userNameTextField.layer.cornerRadius = 8
        
        userNameTextField.textColor = .gray
        passwordTextField.backgroundColor = .white
        passwordTextField.layer.cornerRadius = 8
        passwordTextField.placeholder = "Password"
       
        
        let myAttribute = [ NSAttributedString.Key.foregroundColor: UIColor.gray ]
        let usernamePlaceHolder = NSAttributedString(string: " Username", attributes: myAttribute)
        let passwordPlaceHolder = NSAttributedString(string: " Password", attributes: myAttribute)
        userNameTextField.attributedPlaceholder = usernamePlaceHolder
        passwordTextField.attributedPlaceholder = passwordPlaceHolder
        
        NSLayoutConstraint.activate([
            userNameTextField.heightAnchor.constraint(equalToConstant: 45),
            passwordTextField.heightAnchor.constraint(equalToConstant: 45)
        ])
    }
    
    private func confBotonAcceder(){
        accederButton.backgroundColor = .black
        accederButton.titleLabel?.textColor = .white
        accederButton.layer.cornerRadius = 20
        NSLayoutConstraint.activate([
            accederButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    
    func update(with users: [User]) {
        print("usuarios obtenidos \(users)")
        DispatchQueue.main.async {
            self.users = users
        }
    }
    
    func update(with error: String) {
        print(error)
        DispatchQueue.main.async {
//            self.users = []
//            self.label.isHidden = false
//            self.label.text = error
        }
    }
    
   

    
}
