//
//  CollectionViewCellMovies.swift
//  theMovieDB
//
//  Created by Salma Garcia on 05/11/22.
//

import UIKit

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
        label.font = UIFont(name: "Helvetica Neue Bold", size: 12)
        label.numberOfLines = 0
        label.textColor = .green
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let resumeMovieLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica Neue Bold", size: 10)
        label.numberOfLines = 4
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica Neue Bold", size: 10)
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
        label.font = UIFont(name: "Helvetica Neue Bold", size: 10)
        label.numberOfLines = 4
        label.textColor = .green
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let favoriteButton: UIButton = {
        let button = UIButton(type: .system)
        
        if #available(iOS 15.0, *) {
            var configuration = UIButton.Configuration.filled()
            configuration.image = UIImage(systemName: "heart")
            
            button.translatesAutoresizingMaskIntoConstraints = false
            button.configuration = configuration
            return button
        } else {
            // Fallback on earlier versions
            button.setImage(UIImage(named: "play.png"), for:.normal)
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
        NSLayoutConstraint.activate([
            swiftBetaStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            swiftBetaStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            swiftBetaStackView.topAnchor.constraint(equalTo: self.topAnchor),
            swiftBetaStackView.heightAnchor.constraint(equalToConstant: 190),
            
            infoTextStackView.topAnchor.constraint(equalTo: swiftBetaStackView.layoutMarginsGuide.bottomAnchor),
            infoTextStackView.trailingAnchor.constraint(equalTo: deviceImageView.layoutMarginsGuide.trailingAnchor),
            infoTextStackView.leadingAnchor.constraint(equalTo: deviceImageView.layoutMarginsGuide.leadingAnchor),
            infoTextStackView.bottomAnchor.constraint(equalTo: self.layoutMarginsGuide.bottomAnchor),
            
            deviceImageView.heightAnchor.constraint(equalTo: swiftBetaStackView.heightAnchor),
            
            nameMovieLabel.topAnchor.constraint(equalTo: infoTextStackView.layoutMarginsGuide.topAnchor),
            nameMovieLabel.widthAnchor.constraint(equalTo: infoTextStackView.widthAnchor),
            nameMovieLabel.heightAnchor.constraint(equalToConstant: 35),
            
            dateAndRateStackView.topAnchor.constraint(equalTo: nameMovieLabel.bottomAnchor),
            dateAndRateStackView.trailingAnchor.constraint(equalTo: deviceImageView.layoutMarginsGuide.trailingAnchor),
            dateAndRateStackView.leadingAnchor.constraint(equalTo: deviceImageView.layoutMarginsGuide.leadingAnchor),
            dateAndRateStackView.bottomAnchor.constraint(equalTo: resumeMovieLabel.layoutMarginsGuide.topAnchor),
            
            ratedImage.heightAnchor.constraint(equalToConstant: 10),
            ratedImage.widthAnchor.constraint(equalToConstant: 10),
            pointsLabel.heightAnchor.constraint(equalToConstant: 15),
            pointsLabel.widthAnchor.constraint(equalToConstant: 20),
            
            favoriteButton.topAnchor.constraint(equalTo: swiftBetaStackView.layoutMarginsGuide.topAnchor),
            favoriteButton.heightAnchor.constraint(equalToConstant: 40),
            favoriteButton.widthAnchor.constraint(equalToConstant: 40),
            favoriteButton.leadingAnchor.constraint(equalTo: swiftBetaStackView.layoutMarginsGuide.leadingAnchor),
           
            
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Boton seleccionado
    @objc private func favoriteIn(){
        
        var systemNameForIcon = ""
        let ifFavorite = defaults.bool(forKey: defaultKeys.favorite)
        
        if !ifFavorite {
            systemNameForIcon = imageFavorite.IsFavorite.rawValue
            defaults.set(true, forKey: defaultKeys.favorite)
        } else {
            systemNameForIcon = imageFavorite.IsNotFavorite.rawValue
            defaults.set(false, forKey: defaultKeys.favorite)
        }
        
        if #available(iOS 15.0, *) {
            var configuration = UIButton.Configuration.filled()
            configuration.image = UIImage(systemName: systemNameForIcon)
            
            favoriteButton.translatesAutoresizingMaskIntoConstraints = false
            favoriteButton.configuration = configuration
            
        } else {
            // Fallback on earlier versions
            favoriteButton.setImage(UIImage(systemName: systemNameForIcon), for:.normal)
            favoriteButton.translatesAutoresizingMaskIntoConstraints = false
        
        }
        
        
    }
    
    func configure(model: Result) {
        let url = URL(string: "https://image.tmdb.org/t/p/original/\(model.posterPath)")
        deviceImageView.loader(url: url!)
        nameMovieLabel.text = model.title
        ratedImage.image = UIImage(systemName: "star.fill")
        dateLabel.text = model.releaseDate
        pointsLabel.text = String(model.voteAverage)
        resumeMovieLabel.text = model.overview
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
