//
//  ViewMovies.swift
//  theMovieDB
//
//  Created by Salma Garcia on 04/11/22.
//

import Foundation
import UIKit


protocol AnyViewMovies {
    var presenter: AnyPresenterMovies? { get set }
    
    func update(with users: Popular)
    func update(with error: String)
}

@available(iOS 14.0, *)
class MoviesViewController: UIViewController, AnyViewMovies, UICollectionViewDataSource, UICollectionViewDelegate {

    var presenter: AnyPresenterMovies?
    var dtoPopular:ResultMovies?
    private var customNavigationItem: UINavigationItem!
    private var navigationBar: UINavigationBar!
    let segmentedCategories = UISegmentedControl (items: ["Popular","Top rated","On TV", "Airing Today"])
    
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
        layout.itemSize = .init(width: 178, height: 310)
        layout.scrollDirection = .vertical
        layout.collectionView?.backgroundColor = .darkGray
       
        
        let collectionViewMovies = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionViewMovies.translatesAutoresizingMaskIntoConstraints = false
        return collectionViewMovies
    }()
    
    
    var arrayPopular:[ResultMovies]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(label)
        view.backgroundColor = .darkGray
     
        confNavigationBar()
        
        stackViewVertical.addArrangedSubview(segmentedCategories)
        segmentedCategories.center = view.center
        confCollectionData()
//        stackViewVerticalMovies.addArrangedSubview(collectionViewMovies)
        collectionViewMovies.delegate = self
        collectionViewMovies.dataSource = self
        collectionViewMovies.register(CollectionViewCellMovies.self, forCellWithReuseIdentifier: "CollectionViewCellMovies")
      
       
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionViewMovies.frame = view.bounds
        label.frame = CGRect(x: 0, y: 0, width: 205, height: 50)
        label.center = view.center
        confSegmentedSelected()
        
        
    }
    
    func confCollectionData() {
        collectionViewMovies.backgroundColor = .darkGray
        stackViewVerticalMovies.addArrangedSubview(collectionViewMovies)
        NSLayoutConstraint.activate([
            collectionViewMovies.topAnchor.constraint(equalTo: stackViewVertical.bottomAnchor, constant: 10),
//            collectionViewMovies.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionViewMovies.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 0),
            collectionViewMovies.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor,  constant: 0),
            collectionViewMovies.heightAnchor.constraint(equalTo: view.heightAnchor, constant: 0)
            
        ])
        
    }
    
    func confNavigationBar () {
        navigationBar = UINavigationBar(frame: CGRect(
            x: 0,
            y: 25,
            width: self.view.frame.width,
            height: 44
        ))
        
        customNavigationItem = UINavigationItem()
        
        let rightBarButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(menuOpciones))
        customNavigationItem.rightBarButtonItem = rightBarButton
        customNavigationItem.title = "TV Shows"
        navigationBar.tintColor = .white
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .none
        appearance.shadowColor = .clear
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
//            stackViewVertical.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
//            stackViewVertical.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            stackViewVertical.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackViewVertical.heightAnchor.constraint(equalToConstant: 35)
            
        ])
    }
    private func confStackViewMovies(){
        stackViewVerticalMovies.backgroundColor = .red
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
        
        // Make second segment selected
        segmentedCategories.selectedSegmentIndex = 1
        
        //Change text color of UISegmentedControl
        segmentedCategories.tintColor = UIColor.yellow
        
        //Change UISegmentedControl background colour
        segmentedCategories.backgroundColor = UIColor.darkGray
        
        
        // Add function to handle Value Changed events
        segmentedCategories.addTarget(self, action: #selector(self.segmentedValueChanged(_:)), for: .valueChanged)
    
        
    }
    
    @objc func segmentedValueChanged(_ sender:UISegmentedControl!)
    {
        print("Selected Segment Index is : \(sender.selectedSegmentIndex)")
    }
    
    func update(with popular: Popular) {
        print("usuarios obtenidos")
        DispatchQueue.main.async {
            self.arrayPopular = popular.results
            self.collectionViewMovies.reloadData()
//            self.tableView.isHidden = false
        }
    }
    
    func update(with error: String) {
        print(error)
        DispatchQueue.main.async {
            self.arrayPopular = []
//            self.tableView.isHidden = true
            self.label.isHidden = false
            self.label.text = error
        }
    }
    
    @objc func menuOpciones(){
        print("MENU.......")
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayPopular?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCellMovies", for: indexPath) as! CollectionViewCellMovies
        cell.backgroundColor = .black
        cell.layer.cornerRadius = 15
        let model = (arrayPopular?[indexPath.row])!
        
        cell.configure(model: model)
        return cell
    }
    
}
