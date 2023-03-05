//
//  ViewController.swift
//  AroundEgypt_Clone
//
//  Created by Ziad Alfakharany on 02/03/2023.
//

import UIKit
import SwiftUI


class ViewController: UIViewController {
    
    let searchBar = UISearchBar()
    let sideViewButton = UIButton()
    let costimizeButton = UIButton()
    let welcomeLabel = UILabel()
    let detailText = UILabel()
    let recoTitle = UILabel()
    let recentTitle = UILabel()
    
    var dataManager = DataManager()
    
    private var recommendedcollectionView: UICollectionView?
    
    private var recentcollectionView: UICollectionView?
    
    var cellImageViewString: [String] = ["","","","","","","",""]
    var cellTitleString: [String] = ["","","","","","","",""]
    
    var RcellImageViewString: [String] = ["","","","","","","",""]
    var RcellTitleString: [String] = ["","","","","","","",""]
    
    var cellLikesCount: [Int] = [0,0,0,0,0,0,0,0]
    var RcellLikesCount: [Int] = [0,0,0,0,0,0,0,0]
    
    var cellDescription: [String] = ["","","","","","","",""]
    var RcellDescription: [String] = ["","","","","","","",""]

    
    var singleExTitle: String = ""
    var singleExCoverPic: String = ""
    var singleExDescription: String = ""
    
    var currentID: String = ""
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        dataManager.delegate = self
        
        setUpUI()
    }
    
    func setUpUI() {
        setUpSearchBar()
        setUpButtons()
        setUpLabels()
        setUprecommendedcollectionView()
        setUprecentcollectionView()
    }
    
    func setUpSearchBar() {
        
        searchBar.backgroundColor = .white
        searchBar.searchBarStyle = .minimal
        searchBar.placeholder = "Try “Luxor”"
        
        self.view.addSubview(searchBar)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            searchBar.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            searchBar.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor),
            searchBar.widthAnchor.constraint(equalToConstant: 300),
        ])
    }
    
    func setUpButtons() {
        
        //------------------------------sideViewButton--------------------------------------//
        
        sideViewButton.setImage(UIImage(systemName: "slider.horizontal.3"), for: .normal)
        sideViewButton.tintColor = .black
        
        self.view.addSubview(sideViewButton)
        sideViewButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            sideViewButton.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor, constant: 16),
            sideViewButton.trailingAnchor.constraint(equalTo: self.view.layoutMarginsGuide.trailingAnchor, constant: 10),
            sideViewButton.widthAnchor.constraint(equalToConstant: 40)
        ])
        
        
        
        //------------------------------costimizeButton--------------------------------------//
        
        costimizeButton.setImage(UIImage(systemName: "line.3.horizontal"), for: .normal)
        costimizeButton.tintColor = .black
        
        self.view.addSubview(costimizeButton)
        costimizeButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            costimizeButton.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor, constant: 16),
            costimizeButton.leadingAnchor.constraint(equalTo: self.view.layoutMarginsGuide.leadingAnchor, constant: -10),
            costimizeButton.widthAnchor.constraint(equalToConstant: 40)
        ])
        
    }
    
    func setUpLabels() {
        //------------------------------welcomeLabel--------------------------------------//
        
        welcomeLabel.text = "Welcome!"
        welcomeLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 22)
        self.view.addSubview(welcomeLabel)
        
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            welcomeLabel.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 10),
            welcomeLabel.leadingAnchor.constraint(equalTo: self.view.layoutMarginsGuide.leadingAnchor),
        ])
        
        //------------------------------detailText--------------------------------------//
        
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
        
        
        //------------------------------recoTitle--------------------------------------//
        
        recoTitle.text = "Recommended Experiences"
        recoTitle.font = UIFont(name:"HelveticaNeue-Bold", size: 22)
        self.view.addSubview(recoTitle)
        
        recoTitle.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            recoTitle.topAnchor.constraint(equalTo: detailText.bottomAnchor, constant: 20),
            recoTitle.leadingAnchor.constraint(equalTo: self.view.layoutMarginsGuide.leadingAnchor),
        ])
        
    }
    
    
    func setUprecommendedcollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        layout.itemSize = CGSize(width: 353, height: 225)
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
            recommendedcollectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            recommendedcollectionView.topAnchor.constraint(equalTo: recoTitle.bottomAnchor, constant: 10),
            recommendedcollectionView.widthAnchor.constraint(equalTo: self.view.widthAnchor),
            recommendedcollectionView.heightAnchor.constraint(equalToConstant: 225)
        ])
        
        //------------------------------recentTitle--------------------------------------//
        recentTitle.text = "Most Recent"
        recentTitle.font = UIFont(name:"HelveticaNeue-Bold", size: 22)
        self.view.addSubview(recentTitle)
        
        recentTitle.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            recentTitle.topAnchor.constraint(equalTo: recommendedcollectionView.bottomAnchor, constant: 30),
            recentTitle.leadingAnchor.constraint(equalTo: self.view.layoutMarginsGuide.leadingAnchor),
        ])
    }
    
    
    func setUprecentcollectionView() {
        
        let Vlayout = UICollectionViewFlowLayout()
        Vlayout.scrollDirection = .vertical
        Vlayout.minimumLineSpacing = 10
        Vlayout.itemSize = CGSize(width: 353, height: 225)
        recentcollectionView = UICollectionView(frame: .zero, collectionViewLayout: Vlayout)
        
        guard let recentcollectionView = recentcollectionView else {
            return
        }
        recentcollectionView.register(customCollectionViewCell.self, forCellWithReuseIdentifier: customCollectionViewCell.identifier)
        recentcollectionView.dataSource = self
        recentcollectionView.delegate = self
        self.view.addSubview(recentcollectionView)
        recentcollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            recentcollectionView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            recentcollectionView.leadingAnchor.constraint(equalTo: self.view.layoutMarginsGuide.leadingAnchor),
            recentcollectionView.topAnchor.constraint(equalTo: recentTitle.bottomAnchor, constant: 10),
            recentcollectionView.widthAnchor.constraint(equalTo: self.view.layoutMarginsGuide.widthAnchor),
            recentcollectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
    
    
    func presentSwiftUIView(title: String, pic: String, description: String) {

     var swiftUIView = ExperienceScreen()

        swiftUIView.pic = pic
        swiftUIView.title = title
        swiftUIView.description = description
        
     let hostingController = UIHostingController(rootView: swiftUIView)
     present(hostingController, animated: true, completion: nil)
        
    }
}

//MARK: - ViewController Delegete Methods
extension ViewController:UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.recommendedcollectionView {
            return 8
        } else {
            return 8
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = customCollectionViewCell()
        if let recell = collectionView.dequeueReusableCell(withReuseIdentifier: customCollectionViewCell.identifier, for: indexPath) as? customCollectionViewCell {
            
            if collectionView == self.recommendedcollectionView {
                dataManager.GetRecommendedExperiences()
                recell.configure(with: cellImageViewString[indexPath.row], label: cellTitleString[indexPath.row], likes: cellLikesCount[indexPath.row])
            } else {
                dataManager.GetRecentExperiences()
               recell.configure(with: RcellImageViewString[indexPath.row], label: RcellTitleString[indexPath.row], likes: RcellLikesCount[indexPath.row])
            }
            
            cell = recell
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        dataManager.GetSingleExperience(id: currentID)
        if collectionView == self.recentcollectionView {
            presentSwiftUIView(title: RcellTitleString[indexPath.row], pic: RcellImageViewString[indexPath.row], description: RcellDescription[indexPath.row])
        } else {
            presentSwiftUIView(title: cellTitleString[indexPath.row], pic: cellImageViewString[indexPath.row], description: cellDescription[indexPath.row])
        }
        
    }
}


//MARK: - DataManagerDelegate Method
extension ViewController: DataManagerDelegate {
    func didUpdateSingleEx(_ DataManager: DataManager, data: AroundData) {
        DispatchQueue.main.async {
            self.singleExCoverPic = data.cover_photo
            self.singleExTitle = data.title
            self.singleExDescription = data.description
            print(self.singleExTitle)
        }
    }
    
    func didUpdateRecent(_ DataManager: DataManager, data: [AroundData]) {
        
        DispatchQueue.main.async {
            
            for i in 0...7 {
                self.RcellImageViewString[i] = data[i].cover_photo
                self.RcellTitleString[i] = data[i].title
                self.RcellLikesCount[i] = data[i].likes_no
                self.RcellDescription[i] = data[i].description
                self.currentID = data[i].id
            }
        }
    }
    
    func didUpdateReco(_ DataManager: DataManager, data: [AroundData]) {
        
        DispatchQueue.main.async {
            
            for i in 0...7 {
                self.cellImageViewString[i] = data[i].cover_photo
                self.cellTitleString[i] = data[i].title
                self.cellLikesCount[i] = data[i].likes_no
                self.cellDescription[i] = data[i].description
                self.currentID = data[i].id
            }
        }
    }
 
    func didFailWithError(error: Error) {
        print(error)
    }
    
    
}
