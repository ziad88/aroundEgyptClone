//
//  ViewController.swift
//  AroundEgypt_Clone
//
//  Created by Ziad Alfakharany on 02/03/2023.
//

import UIKit

class ViewController: UIViewController {
 
   
    let searchBar = UISearchBar()
    let sideViewButton = UIButton()
    let costimizeButton = UIButton()
    let welcomeLabel = UILabel()
    let detailText = UILabel()
    let recoTitle = UILabel()
    
    var dataManager = DataManager()
    
    var cellImageViewString: String = ""
    var cellTitleString: String = ""
    
    var index: Int = 0
    
    private var recommendedcollectionView: UICollectionView?
//    = {
//        let recommendedcollectionView = UICollectionView()
//        recommendedcollectionView.allowsSelection = true
//        recommendedcollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "reuseableCell")
//        return recommendedcollectionView
//    }()
    
    private var recentTableView: UITableView?
//    = {
//        let recentTableView = UITableView()
//        recentTableView.allowsSelection = true
//        recentTableView.register(UITableViewCell.self, forCellReuseIdentifier: "reuseableCell")
//        return recentTableView
//    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
                
        dataManager.delegate = self
        dataManager.GetRecommendedExperiences()
        
        
        searchBar.backgroundColor = .white
        searchBar.searchBarStyle = .minimal
        searchBar.placeholder = "Try 'Luxor'"
        
        self.view.addSubview(searchBar)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            searchBar.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            searchBar.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor),
            searchBar.widthAnchor.constraint(equalToConstant: 300),
        ])
        
        
        
        
        
       
        sideViewButton.setImage(UIImage(systemName: "slider.horizontal.3"), for: .normal)
        sideViewButton.tintColor = .black
        
        self.view.addSubview(sideViewButton)
        sideViewButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            sideViewButton.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor, constant: 16),
            sideViewButton.trailingAnchor.constraint(equalTo: self.view.layoutMarginsGuide.trailingAnchor, constant: 10),
            sideViewButton.widthAnchor.constraint(equalToConstant: 40)
        ])
        
       
        
        
        costimizeButton.setImage(UIImage(systemName: "line.3.horizontal"), for: .normal)
        costimizeButton.tintColor = .black
        
        self.view.addSubview(costimizeButton)
        costimizeButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            costimizeButton.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor, constant: 16),
            costimizeButton.leadingAnchor.constraint(equalTo: self.view.layoutMarginsGuide.leadingAnchor, constant: -10),
            costimizeButton.widthAnchor.constraint(equalToConstant: 40)
        ])
        
       
        
        
        welcomeLabel.text = "Welcome!"
        welcomeLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 22)
        self.view.addSubview(welcomeLabel)
        
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            welcomeLabel.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 10),
            welcomeLabel.leadingAnchor.constraint(equalTo: self.view.layoutMarginsGuide.leadingAnchor),
        ])
        
       
        detailText.text = """
        Now you can explore any experience in 360 \
        degrees and get all the details about it all in \
        one place.
        """
        detailText.numberOfLines = 3
        self.view.addSubview(detailText)
        
        detailText.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            detailText.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor),
            detailText.leadingAnchor.constraint(equalTo: self.view.layoutMarginsGuide.leadingAnchor),
            detailText.widthAnchor.constraint(equalTo: self.view.layoutMarginsGuide.widthAnchor)
        ])
        
        recoTitle.text = "Recommended Experiences"
        recoTitle.font = UIFont(name:"HelveticaNeue-Bold", size: 22)
        self.view.addSubview(recoTitle)
        
        recoTitle.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            recoTitle.topAnchor.constraint(equalTo: detailText.bottomAnchor, constant: 20),
            recoTitle.leadingAnchor.constraint(equalTo: self.view.layoutMarginsGuide.leadingAnchor),
        ])

        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        //layout.minimumInteritemSpacing = 2
        layout.itemSize = CGSize(width: 330, height: 225)
        recommendedcollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        guard let recommendedcollectionView = recommendedcollectionView else {
            return
        }
        recommendedcollectionView.register(customCollectionViewCell.self, forCellWithReuseIdentifier: customCollectionViewCell.identifier)
        recommendedcollectionView.dataSource = self
        recommendedcollectionView.delegate = self
        self.view.addSubview(recommendedcollectionView)
        recommendedcollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            recommendedcollectionView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            recommendedcollectionView.leadingAnchor.constraint(equalTo: self.view.layoutMarginsGuide.leadingAnchor),
            recommendedcollectionView.topAnchor.constraint(equalTo: recoTitle.bottomAnchor, constant: 10),
            recommendedcollectionView.widthAnchor.constraint(equalTo: self.view.layoutMarginsGuide.widthAnchor),
            recommendedcollectionView.heightAnchor.constraint(equalToConstant: 225)
        ])
        
    }
   
//    private func setuprecommendedcollectionView() {
//        self.view.addSubview(recommendedcollectionView)
//        recommendedcollectionView.translatesAutoresizingMaskIntoConstraints = false
//
//        NSLayoutConstraint.activate([
//            recommendedcollectionView.topAnchor.constraint(equalTo: detailText.bottomAnchor),
//            recommendedcollectionView.widthAnchor.constraint(equalTo: self.view.layoutMarginsGuide.widthAnchor)
//        ])
//    }
}

extension ViewController:UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = customCollectionViewCell()
        if let recell = collectionView.dequeueReusableCell(withReuseIdentifier: customCollectionViewCell.identifier, for: indexPath) as? customCollectionViewCell {
            index = indexPath.count
            recell.configure(with: cellImageViewString, label: cellTitleString)
            cell = recell
        }
        return cell
    }
    
    
}


extension ViewController: DataManagerDelegate {
    func didUpdate(_ DataManager: DataManager, data: [AroundData]) {
        self.cellImageViewString = data[index].cover_photo
        print(data[index].title)
        self.cellTitleString = data[index].title
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
    
}
