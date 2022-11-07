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
class DetalleMovieViewController: UIViewController, DetalleMovieViewProtocol, UICollectionViewDataSource, UICollectionViewDelegate {

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
    
    //Label Titulo
    private let titleMovieLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    //Label For Adults
    private let isAdultLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    //Label Runtime duration
    private let runtimeLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    //Label Overview Info
    private let overviewLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    //Imagen poster
    private let imageBackgroud: UIImageView = {
        let imageLogo = UIImageView()
        imageLogo.translatesAutoresizingMaskIntoConstraints = false
        return imageLogo
    }()
    
    
    //StackViewPrimerSegmento
    private let StackViewPrimerSegmento: UIStackView = {
        let stackViewVertical = UIStackView()
        stackViewVertical.translatesAutoresizingMaskIntoConstraints = false
        stackViewVertical.axis = .horizontal
        stackViewVertical.spacing = 20
        return stackViewVertical
    }()
    
    //StackViewSegundoSegmento
    private let StackViewSegundoSegmento: UIStackView = {
        let stackViewVertical = UIStackView()
        stackViewVertical.translatesAutoresizingMaskIntoConstraints = false
        stackViewVertical.axis = .horizontal
        stackViewVertical.spacing = 20
        return stackViewVertical
    }()
    
    //StackViewTercerSegmento
    private let StackViewCompaniesSegmento: UIStackView = {
        let stackViewVertical = UIStackView()
        stackViewVertical.translatesAutoresizingMaskIntoConstraints = false
        stackViewVertical.axis = .horizontal
        stackViewVertical.spacing = 20
        return stackViewVertical
    }()
    
    //StackViewGeneros
    private let StackViewOverview: UIStackView = {
        let stackViewHorizontal = UIStackView()
        stackViewHorizontal.translatesAutoresizingMaskIntoConstraints = false
        stackViewHorizontal.axis = .horizontal
        stackViewHorizontal.spacing = 20
        return stackViewHorizontal
    }()
    
    
    //Boton Favorite
    private let favButton: UIButton = {
        let favButton = UIButton(type: .system)
        if #available(iOS 15.0, *) {
            var configuration = UIButton.Configuration.plain()
            configuration.image = UIImage(systemName: "heart")
            favButton.translatesAutoresizingMaskIntoConstraints = false
            favButton.configuration = configuration
            
            return favButton
        } else {
            // Fallback on earlier versions
            favButton.setImage(UIImage(named: "heart"), for:.normal)
            favButton.setTitle("Log in", for: UIControl.State.highlighted)
            return favButton
        }
        
    }()
    
    //CollectionViewCompanies
    private let collectionViewCompanies: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = .init(width: 80, height: 80)
        layout.scrollDirection = .horizontal
        let collectionViewMovies = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionViewMovies.translatesAutoresizingMaskIntoConstraints = false
        return collectionViewMovies
    }()
    
    var arrayCompanies:[ProductionCompany]?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        view.addSubview(stackViewVertical)
        stackViewVertical.addArrangedSubview(imageBackgroud)
        stackViewVertical.addArrangedSubview(titleMovieLabel)
        stackViewVertical.addArrangedSubview(StackViewPrimerSegmento)
        stackViewVertical.addArrangedSubview(overviewLabel)
        stackViewVertical.addArrangedSubview(collectionViewCompanies)
        
        StackViewPrimerSegmento.addArrangedSubview(isAdultLabel)
        StackViewPrimerSegmento.addArrangedSubview(runtimeLabel)
        StackViewPrimerSegmento.addArrangedSubview(favButton)
        
        
//        StackViewSegundoSegmento.addArrangedSubview(favButton)
//        StackViewSegundoSegmento.addArrangedSubview(overviewLabel)
        
        confStackView()
        confStackViewPrimerSegmento()
        confTitleMovieLabel()
        confTitleIsAdultLabel()
        confRunTimeLabel()
        confFavButton()
        confOverviewLabel()
        
        confCollectionData()
//
        collectionViewCompanies.delegate = self
        collectionViewCompanies.dataSource = self
        collectionViewCompanies.register(CollectionViewCellCompanies.self, forCellWithReuseIdentifier: "CollectionViewCellCompanies")
      
      
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    private func confTitleMovieLabel(){
        titleMovieLabel.textColor = .white
        titleMovieLabel.font = UIFont(name: "Helvetica Neue Bold", size: 30)
        NSLayoutConstraint.activate([
            titleMovieLabel.topAnchor.constraint(equalTo: imageBackgroud.layoutMarginsGuide.bottomAnchor),
            titleMovieLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            titleMovieLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            titleMovieLabel.widthAnchor.constraint(equalTo: imageBackgroud.widthAnchor),
            titleMovieLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func confStackViewPrimerSegmento() {
        NSLayoutConstraint.activate([
            StackViewPrimerSegmento.topAnchor.constraint(equalTo: titleMovieLabel.layoutMarginsGuide.bottomAnchor),
            StackViewPrimerSegmento.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            StackViewPrimerSegmento.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
        ])
    }
    
    private func confTitleIsAdultLabel(){
        isAdultLabel.textColor = .white
        isAdultLabel.font = UIFont(name: "Helvetica Neue", size: 10)
        NSLayoutConstraint.activate([
            isAdultLabel.widthAnchor.constraint(equalToConstant: 50),
            isAdultLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func confImage(path: String) {
        let url = URL(string: "\(AppConstant.HOST_MEDIA)\(path)")
        
       
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
        ])
    }
    
    private func confRunTimeLabel() {
        runtimeLabel.textColor = .white
        runtimeLabel.font = UIFont(name: "Helvetica Neue", size: 10)
        NSLayoutConstraint.activate([
            runtimeLabel.widthAnchor.constraint(equalToConstant: 100),
            runtimeLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func confFavButton(){
        NSLayoutConstraint.activate([
            favButton.heightAnchor.constraint(equalToConstant: 40),
            favButton.widthAnchor.constraint(equalToConstant: 40),
        ])
    }
    
    private func confOverviewLabel(){
        overviewLabel.textColor = .white
        overviewLabel.numberOfLines = 0
        overviewLabel.font = UIFont(name: "Helvetica Neue", size: 11)
        NSLayoutConstraint.activate([
            overviewLabel.topAnchor.constraint(equalTo: StackViewPrimerSegmento.layoutMarginsGuide.bottomAnchor),
            overviewLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            overviewLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor)

        ])
    }
    
    func confCollectionData() {
        collectionViewCompanies.backgroundColor = .black
        NSLayoutConstraint.activate([
            collectionViewCompanies.topAnchor.constraint(equalTo: overviewLabel.layoutMarginsGuide.bottomAnchor),
//            collectionViewMovies.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionViewCompanies.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 0),
            collectionViewCompanies.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor,  constant: 0),
            collectionViewCompanies.heightAnchor.constraint(equalToConstant: 80)
            
        ])
        
    }
    
//    Respuesta success
    func detalleMovieResponse(with detalle: DetalleMovie) {
        print("EXITO DETALLE \(detalle.title)")
        if let path = detalle.backdropPath {
            confImage(path: path)
        }
        
        DispatchQueue.main.async {
            self.titleMovieLabel.text = detalle.title
            self.isAdultLabel.text = self.getSimbolForAdults(isAdult: detalle.adult)
            self.runtimeLabel.text = "\(detalle.runtime ?? 0) MINS "
            self.overviewLabel.text = detalle.overview
            self.arrayCompanies = detalle.productionCompanies
            self.collectionViewCompanies.reloadData()
        }
    }
    
//    Respuesta error
    func detalleMovieResponseError(with error: String) {
        print("FAILED DETALLE \(error)")
        DispatchQueue.main.async {
            self.view.backgroundColor = .red
        }
    }
    
//   Get Simbols if is for adults
    
    func getSimbolForAdults(isAdult: Bool) -> String{
        if isAdult {
            return clasification.Adult.rawValue
        } else {
            return clasification.Todos.rawValue
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayCompanies?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCellCompanies", for: indexPath) as! CollectionViewCellCompanies
        cell.backgroundColor = .white
        cell.layer.cornerRadius = 15
        let model = (arrayCompanies?[indexPath.row])!
        
        cell.configureCompanyCell(model: model)
        return cell
    }
    
  
    
}
