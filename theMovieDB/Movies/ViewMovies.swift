//
//  ViewMovies.swift
//  theMovieDB
//
//  Created by Salma Garcia on 04/11/22.
//

import Foundation
import UIKit
import SVProgressHUD


protocol AnyViewMovies {
    var presenter: AnyPresenterMovies? { get set }
    
    func update(with users: Popular)
    func update(with error: String)
    func signOutSuccesss()
    func signOutError(errorMessage: String)
}

@available(iOS 14.0, *)
class MoviesViewController: UIViewController, AnyViewMovies, UICollectionViewDataSource, UICollectionViewDelegate {

    var presenter: AnyPresenterMovies?
    var dtoPopular:ResultMovies?
    private var customNavigationItem: UINavigationItem!
    private var navigationBar: UINavigationBar!
    
    let segmentedCategories = UISegmentedControl (items: ["Popular","Top rated","On TV", "Airing Today"])
    let defaults = UserDefaults.standard
    
    private let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.isHidden = true
        return label
    }()
    
    //StackView
    private let stackViewVertical: UIStackView = {
        let stackViewVertical = UIStackView()
        stackViewVertical.translatesAutoresizingMaskIntoConstraints = false
        stackViewVertical.axis = .vertical
        stackViewVertical.spacing = 20
        return stackViewVertical
    }()
    
    //StackView
    private let stackViewVerticalMovies: UIStackView = {
        let stackViewVerticalMovies = UIStackView()
        stackViewVerticalMovies.translatesAutoresizingMaskIntoConstraints = false
        stackViewVerticalMovies.axis = .vertical
        stackViewVerticalMovies.spacing = 20
        return stackViewVerticalMovies
    }()
    
    //CollectionView
    private let collectionViewMovies: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = .init(width: (UIScreen.main.bounds.width/2)-30, height: 310)
        layout.scrollDirection = .vertical
        layout.collectionView?.backgroundColor = .purple
        let collectionViewMovies = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionViewMovies.translatesAutoresizingMaskIntoConstraints = false
        return collectionViewMovies
    }()
    
    
    var arrayPopular:[ResultMovies]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(label)
        view.backgroundColor = .black
     
        confNavigationBar()
        stackViewVertical.addArrangedSubview(segmentedCategories)
        segmentedCategories.center = view.center
        confCollectionData()
        collectionViewMovies.delegate = self
        collectionViewMovies.dataSource = self
        collectionViewMovies.register(CollectionViewCellMovies.self, forCellWithReuseIdentifier:  AppConstant.colleccionViewCellMovies)
      
       
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        label.frame = CGRect(x: 0, y: 0, width: 205, height: 50)
        label.center = view.center
        confSegmentedSelected()
        
        
    }
    
    func confCollectionData() {
        collectionViewMovies.backgroundColor = .black
        stackViewVerticalMovies.addArrangedSubview(collectionViewMovies)
        NSLayoutConstraint.activate([
            collectionViewMovies.topAnchor.constraint(equalTo: stackViewVertical.bottomAnchor, constant: 10),
            collectionViewMovies.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 0),
            collectionViewMovies.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor,  constant: 0),
            collectionViewMovies.heightAnchor.constraint(equalTo: view.layoutMarginsGuide.heightAnchor, multiplier: 4/5)
            
        ])
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func confNavigationBar () {
        navigationBar = UINavigationBar(frame: CGRect(
            x: 0,
            y: UIScreen.main.bounds.height/15,
            width: self.view.frame.width,
            height: 44
        ))
       
        customNavigationItem = UINavigationItem()
        let rightBarButton = UIBarButtonItem(image: UIImage(systemName: AppConstant.icono_menu), style: .plain, target: self, action: #selector(menuOpciones))
        rightBarButton.tintColor = .white
        
        customNavigationItem.rightBarButtonItem = rightBarButton
        customNavigationItem.title = AppConstant.title_navbar
        navigationBar.tintColor = .white
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .darkGray
        appearance.shadowColor = .clear
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationBar.isTranslucent = false
        navigationBar.standardAppearance = appearance
            
        navigationBar.items = [customNavigationItem]
        view.addSubview(navigationBar)
        view.addSubview(stackViewVertical)
        view.addSubview(stackViewVerticalMovies)
        confStackView()
        confStackViewMovies()
        
    }
    
    private func confStackView(){
        NSLayoutConstraint.activate([
            stackViewVertical.topAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: 10),
            stackViewVertical.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackViewVertical.heightAnchor.constraint(equalToConstant: 35)
            
        ])
    }
    private func confStackViewMovies(){
        stackViewVerticalMovies.backgroundColor = .black
        NSLayoutConstraint.activate([
            stackViewVerticalMovies.topAnchor.constraint(equalTo: stackViewVertical.bottomAnchor, constant: 10),
            stackViewVerticalMovies.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
            stackViewVerticalMovies.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 0),
            stackViewVerticalMovies.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor,  constant: 0),
            stackViewVerticalMovies.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            
        ])
    }
    
    func confSegmentedSelected () {
       
        segmentedCategories.frame.size.height = 40
        let tipoVista = UserDefaults.standard.integer(forKey: defaultKeys.segmento)
        segmentedCategories.selectedSegmentIndex = tipoVista
        segmentedCategories.tintColor = UIColor.yellow
        segmentedCategories.backgroundColor = UIColor.darkGray
        segmentedCategories.addTarget(self, action: #selector(self.segmentedValueChanged(_:)), for: .valueChanged)
    }
    
    @objc func segmentedValueChanged(_ sender:UISegmentedControl!)
    {
        let moviesCategory = sender.selectedSegmentIndex
        self.defaults.set(moviesCategory, forKey: defaultKeys.segmento)
        segmentedCategories.selectedSegmentIndex = moviesCategory
        self.presenter?.interactor?.getMovies(category: moviesCategory)
        self.collectionViewMovies.reloadData()
    }
    
    func update(with popular: Popular) {
        DispatchQueue.main.async {
            self.arrayPopular = popular.results
            self.collectionViewMovies.reloadData()
        }
    }
    
    func update(with error: String) {
        print(error)
        DispatchQueue.main.async {
            self.arrayPopular = []
            self.label.isHidden = false
            self.label.text = error
        }
    }
    
    @objc func menuOpciones(){
        let alert = UIAlertController(title: AppConstant.what_do_you_want_to_do, message: nil, preferredStyle: UIAlertController.Style.actionSheet)
        alert.addAction(UIAlertAction(title: AppConstant.view_profile, style: UIAlertAction.Style.default, handler: navegarViewProfile))
        alert.addAction(UIAlertAction(title: AppConstant.log_out, style: UIAlertAction.Style.destructive, handler: cerrarSesion))
        alert.addAction(UIAlertAction(title: AppConstant.cancelar, style: UIAlertAction.Style.cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    // View Profile Action
    func navegarViewProfile(alert: UIAlertAction!) {
        self.dismiss(animated: true)
        let userRouter = ProfileRouter.start()
        let initialVC = userRouter.entry
        initialVC!.modalPresentationStyle = .overCurrentContext
        let navigationVc = UINavigationController(rootViewController: initialVC!)
        navigationVc.modalPresentationStyle = .automatic
        self.present(navigationVc, animated: true, completion: nil)
    }
    // View Profile Action
    func navegarViewFavorites(alert: UIAlertAction!) {
        self.dismiss(animated: true)
        let userRouter = FavoritesRouter.start()
        let initialVC = userRouter.entry
        initialVC!.modalPresentationStyle = .overCurrentContext
        let navigationVc = UINavigationController(rootViewController: initialVC!)
        navigationVc.modalPresentationStyle = .automatic
        self.present(navigationVc, animated: true, completion: nil)
    }
    
    // Cerrar Sesion
    func cerrarSesion(alert: UIAlertAction!) {
        SVProgressHUD.show(withStatus: AppConstant.cargando)
        presenter?.interactor?.cerrarSession()
    }
    
    func signOutSuccesss() {
        SVProgressHUD.dismiss()
        let userRouter = UserRouter.start()
        let initialVC = userRouter.entry
        let navigationVc = UINavigationController(rootViewController: initialVC!)
        navigationVc.modalPresentationStyle = .fullScreen
        self.present(navigationVc, animated: true, completion: nil)
    }
    
    func signOutError(errorMessage: String) {
        let alert = UIAlertController(title: AppConstant.errorMessage, message: errorMessage, preferredStyle: UIAlertController.Style.actionSheet)
        self.present(alert, animated: true, completion: nil)
    }
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayPopular?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppConstant.colleccionViewCellMovies, for: indexPath) as! CollectionViewCellMovies
        cell.backgroundColor = .darkGray
        cell.layer.cornerRadius = 15
        let model = (arrayPopular?[indexPath.row])!
        let tipoVista = defaults.integer(forKey: defaultKeys.segmento)
        cell.configure(model: model, tipo: tipoVista)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        DispatchQueue.main.async {
            
            let model = (self.arrayPopular?[indexPath.row])!
            self.defaults.set(model.id, forKey: defaultKeys.id_movie)
            let userRouter = DetalleMovieRouter.start()
            let initialVC = userRouter.entry
            initialVC!.modalPresentationStyle = .overCurrentContext
            let navigationVc = UINavigationController(rootViewController: initialVC!)
            navigationVc.modalPresentationStyle = .automatic
            self.present(navigationVc, animated: true, completion: nil)
            
            
        }
    }
    
}
