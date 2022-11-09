//
//  CollectionViewCellCompanies.swift
//  theMovieDB
//
//  Created by Salma Garcia on 06/11/22.
//

import UIKit

class CollectionViewCellCompanies: UICollectionViewCell {
    
    
    private let movieImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 15
        imageView.tintColor = .green
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let labelName: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: AppConstant.font_helvetica, size: 10)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    //StackView
    private let StackViewCompanies: UIStackView = {
        let stackViewHorizontal = UIStackView()
        stackViewHorizontal.translatesAutoresizingMaskIntoConstraints = false
        stackViewHorizontal.axis = .horizontal
        return stackViewHorizontal
    }()
    
    //CollectionView
    private let collectionViewVideo: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = .init(width: 178, height: 310)
        layout.scrollDirection = .vertical
        layout.collectionView?.backgroundColor = .purple
       
        
        let collectionViewMovies = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionViewMovies.translatesAutoresizingMaskIntoConstraints = false
        return collectionViewMovies
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError(AppConstant.init_code_message)
    }
    
    func configureCompanyCell(model: ProductionCompany) {
        let modelo = model.logoPath
        if modelo != nil {
            addSubview(movieImageView)
            NSLayoutConstraint.activate([
                movieImageView.topAnchor.constraint(equalTo: self.topAnchor),
                movieImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
                movieImageView.widthAnchor.constraint(equalToConstant: 80),
                movieImageView.heightAnchor.constraint(equalToConstant: 80),
            ])
           
            let url = URL(string: "\(AppConstant.HOST_MEDIA)\(modelo ?? "")")
            movieImageView.loader(url: url!)
        } else {
            addSubview(StackViewCompanies)
            StackViewCompanies.addArrangedSubview(labelName)
            labelName.numberOfLines = 0
         
            NSLayoutConstraint.activate([
                labelName.topAnchor.constraint(equalTo: self.topAnchor),
                labelName.bottomAnchor.constraint(equalTo: self.bottomAnchor),
                labelName.trailingAnchor.constraint(equalTo: self.trailingAnchor),
                labelName.leadingAnchor.constraint(equalTo: self.leadingAnchor)
            ])
            labelName.text = model.name
        }
       
    }
    
    
}

