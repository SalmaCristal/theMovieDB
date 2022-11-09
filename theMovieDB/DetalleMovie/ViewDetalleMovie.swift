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
    func videoResponse(with detalle: DetalleVideo)
    func videoResponseError(with error: String)
}

@available(iOS 14.0, *)
class DetalleMovieViewController: UIViewController, DetalleMovieViewProtocol, UICollectionViewDataSource , UICollectionViewDelegate {
    
    var presenter: DetalleMoviePresenterProtocol?
    var interactor: DetalleMovieInteractorProtocol?
    var router: DetalleMovieRouterProtocol?
    var arrayDetalles:[DetalleMovie]?
    let scrollView = UIScrollView()
    let contentView = UIView()
    
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
    
    //StackViewDescripción
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
            var configuration = UIButton.Configuration.filled()
            configuration.image = UIImage(systemName: AppConstant.icono_heart)
            favButton.translatesAutoresizingMaskIntoConstraints = false
            favButton.configuration = configuration
            
            return favButton
        } else {
            // Fallback on earlier versions
            favButton.setImage(UIImage(named: AppConstant.icono_heart), for:.normal)
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
    
    //CollectionViewVideos
    private let collectionViewVideos: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = .init(width: 200, height: 130)
        layout.scrollDirection = .horizontal
        let collectionViewMovies = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionViewMovies.translatesAutoresizingMaskIntoConstraints = false
        return collectionViewMovies
    }()
    
    
    var arrayCompanies:[ProductionCompany]?
    var arrayVideos:[Video]?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScrollView()
        
        view.backgroundColor = .black
        contentView.addSubview(stackViewVertical)
        stackViewVertical.addArrangedSubview(imageBackgroud)
        stackViewVertical.addArrangedSubview(titleMovieLabel)
        stackViewVertical.addArrangedSubview(StackViewPrimerSegmento)
        stackViewVertical.addArrangedSubview(overviewLabel)
        stackViewVertical.addArrangedSubview(collectionViewCompanies)
        stackViewVertical.addArrangedSubview(collectionViewVideos)
        
        StackViewPrimerSegmento.addArrangedSubview(isAdultLabel)
        StackViewPrimerSegmento.addArrangedSubview(runtimeLabel)
        StackViewPrimerSegmento.addArrangedSubview(favButton)
        
        confStackView()
        confStackViewPrimerSegmento()
        confTitleMovieLabel()
        confTitleIsAdultLabel()
        confRunTimeLabel()
        confFavButton()
        confOverviewLabel()
        
        confCollectionData()
        confCollectionDataVideo()
        
        collectionViewCompanies.delegate = self
        collectionViewCompanies.dataSource = self
        collectionViewCompanies.register(CollectionViewCellCompanies.self, forCellWithReuseIdentifier: AppConstant.colleccionViewCompanies)
        
        collectionViewVideos.delegate = self
        collectionViewVideos.dataSource = self
        collectionViewVideos.register(CollectionViewCellVideo.self, forCellWithReuseIdentifier: AppConstant.colleccionViewCellVideos)
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    func setupScrollView(){
        scrollView.backgroundColor = .black
        contentView.backgroundColor = .black
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
    }
    
    private func confTitleMovieLabel(){
        titleMovieLabel.textColor = .white
        titleMovieLabel.font = UIFont(name: AppConstant.font_helvetica_bold, size: 30)
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
        isAdultLabel.font = UIFont(name: AppConstant.font_helvetica, size: 10)
        NSLayoutConstraint.activate([
            isAdultLabel.widthAnchor.constraint(equalToConstant: 60),
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
            stackViewVertical.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            stackViewVertical.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            stackViewVertical.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
            stackViewVertical.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 3/4),
            stackViewVertical.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            
        ])
    }
    
    private func confRunTimeLabel() {
        runtimeLabel.textColor = .white
        runtimeLabel.font = UIFont(name: AppConstant.font_helvetica_bold, size: 10)
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
        overviewLabel.font = UIFont(name: AppConstant.font_helvetica, size: 20)
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
            collectionViewCompanies.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 0),
            collectionViewCompanies.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor,  constant: 0),
            collectionViewCompanies.heightAnchor.constraint(equalToConstant: 80)
            
        ])
        
    }
    
    func confCollectionDataVideo() {
        collectionViewVideos.backgroundColor = .black
        NSLayoutConstraint.activate([
            collectionViewVideos.topAnchor.constraint(equalTo: collectionViewCompanies.bottomAnchor, constant: 10),
            collectionViewVideos.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 0),
            collectionViewVideos.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor,  constant: 0),
            collectionViewVideos.heightAnchor.constraint(equalToConstant: 180),
            collectionViewVideos.widthAnchor.constraint(equalTo: stackViewVertical.widthAnchor)
            
        ])
        
    }
    
    //   Get Simbols if is for adults
    func getSimbolForAdults(isAdult: Bool) -> String{
        if isAdult == false {
            return clasification.Todos.rawValue
        } else {
            return clasification.Adult.rawValue
        }
        
    }
    
    //    Respuesta Detalle success
    func detalleMovieResponse(with detalle: DetalleMovie) {
        if let path = detalle.backdropPath {
            confImage(path: path)
        }
        let defaults = UserDefaults.standard
        let tipo = defaults.string(forKey: defaultKeys.is_tv_or_movie)
        DispatchQueue.main.async {
            if (tipo! <= showsType.Movie.rawValue ) {
                self.titleMovieLabel.text = detalle.title
                self.isAdultLabel.text = self.getSimbolForAdults(isAdult: detalle.adult)
                self.runtimeLabel.text = "\(detalle.runtime ?? 0) \(AppConstant.minutos)"
            } else {
                self.titleMovieLabel.text = detalle.name
                self.isAdultLabel.text = detalle.firstAirDate
                self.runtimeLabel.text = detalle.lastAirDate
            }
            self.overviewLabel.text = detalle.overview
            self.arrayCompanies = detalle.productionCompanies
            self.collectionViewCompanies.reloadData()
           
        }
    }
    
    //    Respuesta error
    func detalleMovieResponseError(with error: String) {
        DispatchQueue.main.async {
            self.view.backgroundColor = .red
        }
    }
    
    //    Respuesta Detalle success
    func videoResponse(with detalle: DetalleVideo) {
        DispatchQueue.main.async {
            self.arrayVideos = detalle.results
            self.collectionViewVideos.reloadData()
            
        }
    }
    
    //    Respuesta error
    func videoResponseError(with error: String) {
        DispatchQueue.main.async {
            self.view.backgroundColor = .red
        }
    }
    

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == collectionViewVideos {
            return arrayVideos?.count ?? 0
        }
        return arrayCompanies?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        if collectionView == self.collectionViewVideos {
            let cell2 = collectionViewVideos.dequeueReusableCell(withReuseIdentifier: AppConstant.colleccionViewCellVideos, for: indexPath) as! CollectionViewCellVideo
            cell2.backgroundColor = .red
            cell2.layer.cornerRadius = 15
            let model = (arrayVideos?[indexPath.row])!
            cell2.configureVideoCell(model: model)
            return cell2
        } else {
            let cell = collectionViewCompanies.dequeueReusableCell(withReuseIdentifier: AppConstant.colleccionViewCompanies, for: indexPath) as! CollectionViewCellCompanies
            cell.backgroundColor = .white
            cell.layer.cornerRadius = 15
            let model = (arrayCompanies?[indexPath.row])!
            cell.configureCompanyCell(model: model)
            return cell
        }
      
    }
}
