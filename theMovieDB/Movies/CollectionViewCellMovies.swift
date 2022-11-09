//
//  CollectionViewCellMovies.swift
//  theMovieDB
//
//  Created by Salma Garcia on 05/11/22.
//

import UIKit

@available(iOS 14.0, *)
class CollectionViewCellMovies: UICollectionViewCell {
    let defaults = UserDefaults.standard
   
    private let swiftBetaStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.layer.borderColor = UIColor.black.cgColor
        stackView.layer.cornerRadius = 15
        return stackView
    }()
    
    private let infoTextStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.layer.borderColor = UIColor.black.cgColor
        stackView.spacing = 8
        
        return stackView
    }()
    
    private let dateAndRateStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.layer.borderColor = UIColor.black.cgColor
        
        return stackView
    }()
    
    private let deviceImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 15
        imageView.tintColor = .green
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let nameMovieLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: AppConstant.font_helvetica_bold, size: 12)
        label.numberOfLines = 0
        label.textColor = .green
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let resumeMovieLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: AppConstant.font_helvetica_bold, size: 10)
        label.numberOfLines = 4
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: AppConstant.font_helvetica_bold, size: 10)
        label.numberOfLines = 4
        label.textColor = .green
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let ratedImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .green
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let pointsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: AppConstant.font_helvetica_bold, size: 10)
        label.numberOfLines = 4
        label.textColor = .green
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let favoriteButton: UIButton = {
        let button = UIButton(type: .system)
        
        if #available(iOS 15.0, *) {
            var configuration = UIButton.Configuration.filled()
            configuration.image = UIImage(systemName: AppConstant.icono_heart)
            
            button.translatesAutoresizingMaskIntoConstraints = false
            button.configuration = configuration
            return button
        } else {
            // Fallback on earlier versions
            button.setImage(UIImage(named: AppConstant.icono_heart), for:.normal)
            button.translatesAutoresizingMaskIntoConstraints = false
            return button
        }
      }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        addSubview(swiftBetaStackView)
        addSubview(infoTextStackView)
        addSubview(favoriteButton)
        
        swiftBetaStackView.addArrangedSubview(deviceImageView)
        
        infoTextStackView.addArrangedSubview(nameMovieLabel)
        infoTextStackView.addArrangedSubview(dateAndRateStackView)
        infoTextStackView.addArrangedSubview(resumeMovieLabel)
        
        dateAndRateStackView.addArrangedSubview(dateLabel)
        dateAndRateStackView.addArrangedSubview(ratedImage)
        dateAndRateStackView.addArrangedSubview(pointsLabel)
        
        favoriteButton.addTarget(self, action: #selector(favoriteIn), for: .touchUpInside)
    
        confPrimerStackView()
        confInfoImageAndLabelName()
        confDateAndRateStackView()
        confPointsAndRated()
        confFavoriteButton()
    }
    
    private func confPrimerStackView () {
        NSLayoutConstraint.activate([
            swiftBetaStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            swiftBetaStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            swiftBetaStackView.topAnchor.constraint(equalTo: self.topAnchor),
            swiftBetaStackView.heightAnchor.constraint(equalToConstant: 190),
            
        ])
   }
    
    
    private func confInfoImageAndLabelName () {
       NSLayoutConstraint.activate([
        infoTextStackView.topAnchor.constraint(equalTo: swiftBetaStackView.layoutMarginsGuide.bottomAnchor),
        infoTextStackView.trailingAnchor.constraint(equalTo: deviceImageView.layoutMarginsGuide.trailingAnchor),
        infoTextStackView.leadingAnchor.constraint(equalTo: deviceImageView.layoutMarginsGuide.leadingAnchor),
        infoTextStackView.bottomAnchor.constraint(equalTo: self.layoutMarginsGuide.bottomAnchor),
        
        deviceImageView.heightAnchor.constraint(equalTo: swiftBetaStackView.heightAnchor),
        
        nameMovieLabel.topAnchor.constraint(equalTo: infoTextStackView.layoutMarginsGuide.topAnchor),
        nameMovieLabel.widthAnchor.constraint(equalTo: infoTextStackView.widthAnchor),
        nameMovieLabel.heightAnchor.constraint(equalToConstant: 35),
      ])
   }
    
     private func confDateAndRateStackView () {
        NSLayoutConstraint.activate([
            dateAndRateStackView.topAnchor.constraint(equalTo: nameMovieLabel.bottomAnchor),
            dateAndRateStackView.trailingAnchor.constraint(equalTo: deviceImageView.layoutMarginsGuide.trailingAnchor),
            dateAndRateStackView.leadingAnchor.constraint(equalTo: deviceImageView.layoutMarginsGuide.leadingAnchor),
            dateAndRateStackView.bottomAnchor.constraint(equalTo: resumeMovieLabel.layoutMarginsGuide.topAnchor),
       ])
    }
    
    private func confPointsAndRated () {
        NSLayoutConstraint.activate([
        ratedImage.heightAnchor.constraint(equalToConstant: 10),
        ratedImage.widthAnchor.constraint(equalToConstant: 10),
        pointsLabel.heightAnchor.constraint(equalToConstant: 15),
        pointsLabel.widthAnchor.constraint(equalToConstant: 20),
       ])
    }
    
    private func confFavoriteButton () {
        NSLayoutConstraint.activate([
        favoriteButton.topAnchor.constraint(equalTo: swiftBetaStackView.layoutMarginsGuide.topAnchor),
        favoriteButton.heightAnchor.constraint(equalToConstant: 40),
        favoriteButton.widthAnchor.constraint(equalToConstant: 40),
        favoriteButton.leadingAnchor.constraint(equalTo: swiftBetaStackView.layoutMarginsGuide.leadingAnchor),
       ])
    }
    
    required init?(coder: NSCoder) {
        fatalError(AppConstant.init_code_message)
    }
    

    
    // MARK: - Boton seleccionado
    @objc private func favoriteIn(){
        
        let systemNameForIcon = Utilities().changeEstateButtonFavorite()
        let iconoFav = systemNameForIcon.0
        let accionFav = systemNameForIcon.1
        _ = systemNameForIcon.2
        
        if #available(iOS 15.0, *) {
            
            var configuration = UIButton.Configuration.filled()
            configuration.image = UIImage(systemName: iconoFav!)
            favoriteButton.translatesAutoresizingMaskIntoConstraints = false
            favoriteButton.configuration = configuration
            
        } else {
            // Fallback on earlier versions
            favoriteButton.setImage(UIImage(systemName: iconoFav!), for:.normal)
            favoriteButton.translatesAutoresizingMaskIntoConstraints = false
        
        }
        
        if accionFav == accionFavoritos.guardarFav.rawValue {
//            presenter?.interactor?.guardarMovie(id: idMovie)

        } else {
//            presenter?.interactor
        }
    }
    
 
    
    func configure(model: Result, tipo: Int) {
        let url = URL(string: "\(AppConstant.HOST_MEDIA)\(model.posterPath)")
        let overview = model.overview
        let title = model.title
        deviceImageView.loader(url: url!)
    
        ratedImage.image = UIImage(systemName: AppConstant.icono_star_fill)
        
        pointsLabel.text = String(model.voteAverage)
        resumeMovieLabel.text = overview
        if (tipo <= segmentosType.TopRates.rawValue ) {
            self.defaults.set(showsType.Movie.rawValue, forKey: defaultKeys.is_tv_or_movie)
            nameMovieLabel.text = title
            dateLabel.text = model.releaseDate
        } else {
            self.defaults.set(showsType.TV.rawValue, forKey: defaultKeys.is_tv_or_movie)
            nameMovieLabel.text = model.name
            dateLabel.text = model.firstAirDate
        }
    }
}

extension UIImageView {
    func loader(url:URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
