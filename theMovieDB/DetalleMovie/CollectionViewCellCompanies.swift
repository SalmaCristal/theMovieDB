//
//  CollectionViewCellCompanies.swift
//  theMovieDB
//
//  Created by Salma Garcia on 06/11/22.
//

import UIKit

class CollectionViewCellCompanies: UICollectionViewCell {
    
    
    private let deviceImageView: UIImageView = {
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
        label.font = UIFont(name: "Helvetica Neue Bold", size: 3)
        label.textColor = .black
        label.backgroundColor = .green
        return label
    }()
    

    override init(frame: CGRect) {
        super.init(frame: .zero)
        
      
       
        
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCompanyCell(model: ProductionCompany) {
        print("COMPANY \(model.name)")
        let modelo = model.logoPath
        if modelo != nil {
            addSubview(deviceImageView)
            NSLayoutConstraint.activate([
                deviceImageView.topAnchor.constraint(equalTo: self.topAnchor),
                deviceImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
                deviceImageView.widthAnchor.constraint(equalToConstant: 80),
                deviceImageView.heightAnchor.constraint(equalToConstant: 80),
            ])
           
            let url = URL(string: "\(AppConstant.HOST_MEDIA)\(modelo ?? "")")
            deviceImageView.loader(url: url!)
        } else {
            addSubview(labelName)
            labelName.numberOfLines = 0
         
            NSLayoutConstraint.activate([
                labelName.topAnchor.constraint(equalTo: self.topAnchor),
                labelName.bottomAnchor.constraint(equalTo: self.bottomAnchor),
                labelName.widthAnchor.constraint(equalToConstant: 100),
            ])
            labelName.text = "Company"
            print("SIN FOTO COMPANY \(model.name)")
        }
       
    }
    
    
}

