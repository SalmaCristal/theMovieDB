//
//  CollectionViewCellVideos.swift
//  theMovieDB
//
//  Created by Salma Garcia on 08/11/22.
//

import Foundation
import UIKit

class CollectionViewCellVideo: UICollectionViewCell {
    
    //Background Image
    private let playImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .center
        imageView.clipsToBounds = true
        imageView.tintColor = .white
        imageView.image = UIImage(systemName: AppConstant.icono_play)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    //Label
    private let labelName: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: AppConstant.font_helvetica, size: 12)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    //StackView
    private let StackViewVideo: UIStackView = {
        let stackViewHorizontal = UIStackView()
        stackViewHorizontal.backgroundColor = .purple
        stackViewHorizontal.layer.cornerRadius = 15
        stackViewHorizontal.translatesAutoresizingMaskIntoConstraints = false
        stackViewHorizontal.axis = .vertical
        return stackViewHorizontal
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        addSubview(StackViewVideo)
        StackViewVideo.addArrangedSubview(labelName)
        StackViewVideo.addArrangedSubview(playImageView)
        labelName.numberOfLines = 0
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureVideoCell(model: Video) {
        NSLayoutConstraint.activate([
            StackViewVideo.topAnchor.constraint(equalTo: self.topAnchor),
            StackViewVideo.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            StackViewVideo.widthAnchor.constraint(equalToConstant: 200),
            labelName.topAnchor.constraint(equalTo: self.topAnchor),
            labelName.heightAnchor.constraint(equalToConstant: 40),
            labelName.widthAnchor.constraint(equalTo: StackViewVideo.widthAnchor),
            playImageView.leadingAnchor.constraint(equalTo: StackViewVideo.leadingAnchor, constant: 50),
            playImageView.trailingAnchor.constraint(equalTo: StackViewVideo.trailingAnchor, constant: -50)
        ])
        labelName.text = model.name
    }
}


