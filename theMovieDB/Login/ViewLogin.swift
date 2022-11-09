//
//  ViewLogin.swift
//  theMovieDB
//
//  Created by Salma Garcia on 03/11/22.
//

import Foundation
import UIKit
import SVProgressHUD


protocol AnyView {
    var presenter: AnyPresenter? { get set }
    var interactor: AnyInteractor? { get set }
    func loginResponse(with result: String)
    func loginResponseError(with error: String)
    
}

@available(iOS 14.0, *)
class LoginViewController: UIViewController, AnyView {
    
    
    
    var presenter: AnyPresenter?
    var interactor: AnyInteractor?
    var router: AnyRouter?
   
    //Label
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
    
    //Boton Acceder
    private let accederButton: UIButton = {
        let accederButton = UIButton(type: .system)
        if #available(iOS 15.0, *) {
            var configuration = UIButton.Configuration.filled()
            configuration.title = AppConstant.log_in
            accederButton.translatesAutoresizingMaskIntoConstraints = false
            accederButton.configuration = configuration
            
            return accederButton
        } else {
            // Fallback on earlier versions
            accederButton.setTitle(AppConstant.log_in, for: UIControl.State.highlighted)
            return accederButton
        }
        
    }()
    
    //Imagen logo
    private let imageLogo: UIImageView = {
        let imageLogo = UIImageView()
        imageLogo.image = UIImage(named: AppConstant.icono_login)
        imageLogo.translatesAutoresizingMaskIntoConstraints = false
        return imageLogo
    }()
    //View logo
    private let viewTransparent: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.7)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //StackView
    private let stackViewVertical: UIStackView = {
        let stackViewVertical = UIStackView()
        stackViewVertical.translatesAutoresizingMaskIntoConstraints = false
        stackViewVertical.axis = .vertical
        stackViewVertical.spacing = 20
        
        return stackViewVertical
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        comprobarSesionUsuarioAutenticado ()
        hideKeyboardWhenTappedAround()
        view.addSubview(imageLogo)
        view.addSubview(viewTransparent)
        view.addSubview(stackViewVertical)
        SVProgressHUD.setContainerView(view)
        SVProgressHUD.setBackgroundColor(.white)
        SVProgressHUD.setInfoImage(.add)
        
        confStackView()
        confImage()
        confViewTransparent()
        stackViewVertical.addArrangedSubview(userNameTextField)
        stackViewVertical.addArrangedSubview(passwordTextField)
        stackViewVertical.addArrangedSubview(accederButton)
        stackViewVertical.addArrangedSubview(label)
        accederButton.addTarget(self, action: #selector(loginButonListener), for: .touchUpInside)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        confEditText()
        confBotonAcceder()
        confLabelError()
    }
    
    private func confLabelError() {
        label.textColor = .red
        label.numberOfLines = 0
        label.font = UIFont(name: AppConstant.font_helvetica, size: 13)
        NSLayoutConstraint.activate([
            label.heightAnchor.constraint(equalToConstant: 25),
        ])
    }
    
    private func confImage() {
        NSLayoutConstraint.activate([ // 5
            imageLogo.heightAnchor.constraint(equalTo: view.heightAnchor),
            imageLogo.widthAnchor.constraint(equalTo: view.widthAnchor),
            imageLogo.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            imageLogo.topAnchor.constraint(equalTo: view.topAnchor)
                                    ])
    }
    
    private func confViewTransparent() {
        
        NSLayoutConstraint.activate([ // 5
            viewTransparent.heightAnchor.constraint(equalTo: view.heightAnchor),
            viewTransparent.widthAnchor.constraint(equalTo: view.widthAnchor),
            viewTransparent.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            viewTransparent.topAnchor.constraint(equalTo: view.topAnchor)
                                    ])
    }
    
    private func confStackView(){
        NSLayoutConstraint.activate([
                   stackViewVertical.topAnchor.constraint(equalTo: imageLogo.bottomAnchor, constant: 45),
                   stackViewVertical.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 20),
                   stackViewVertical.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -20),
                   stackViewVertical.centerYAnchor.constraint(equalTo: view.centerYAnchor)
                   
               ])
    }
    
    private func confEditText(){
        userNameTextField.backgroundColor = .white
        userNameTextField.layer.cornerRadius = 8
        
        userNameTextField.textColor = .gray
        passwordTextField.backgroundColor = .white
        passwordTextField.layer.cornerRadius = 8
        passwordTextField.placeholder = AppConstant.password
       
        
        let myAttribute = [ NSAttributedString.Key.foregroundColor: UIColor.gray ]
        let usernamePlaceHolder = NSAttributedString(string: " \(AppConstant.username)", attributes: myAttribute)
        let passwordPlaceHolder = NSAttributedString(string: " \(AppConstant.password)", attributes: myAttribute)
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
    
    // MARK: - Boton seleccionado
    @objc private func loginButonListener(){
       
        if userNameTextField.text != "", passwordTextField.text != ""{
            SVProgressHUD.show(withStatus: AppConstant.cargando)
            self.presenter?.interactor?.login(
                username: userNameTextField.text!,
                password: passwordTextField.text!
            )
        }else {
            self.loginResponseError(with: AppConstant.campos_vacios_message)
        }
    }
    
    
//    Respuesta success
    func loginResponse(with result: String) {
       
        DispatchQueue.main.async {
            SVProgressHUD.dismiss()
            self.view.backgroundColor = .yellow
            let userRouter = MoviesRouter.start()
            let initialVC = userRouter.entry
            UIApplication.shared.windows.first?.rootViewController = initialVC
            UIApplication.shared.windows.first?.makeKeyAndVisible()
        }
    }
    
//    Respuesta error
    func loginResponseError(with error: String) {
        DispatchQueue.main.async {
            SVProgressHUD.dismiss()
            self.view.backgroundColor = .red
            self.label.isHidden = false
            self.label.text = error
        }
    }
    
    func comprobarSesionUsuarioAutenticado () {
        let defaults = UserDefaults.standard
        if let email = defaults.value(forKey: defaultKeys.email) as? String{
            self.view.backgroundColor = .yellow
            let userRouter = MoviesRouter.start()
            let initialVC = userRouter.entry
            UIApplication.shared.windows.first?.rootViewController = initialVC
            UIApplication.shared.windows.first?.makeKeyAndVisible()
        }
    }
}
