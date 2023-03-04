//
//  customCollectionViewCell.swift
//  AroundEgypt_Clone
//
//  Created by Ziad Alfakharany on 03/03/2023.
//

import UIKit

class customCollectionViewCell: UICollectionViewCell {
    
    var dataManager = DataManager()
    
    static let identifier = "customCollectionViewCell"
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private let title: UILabel = {
        let title = UILabel()
        return title
    }()
    
    private let likesCount: UILabel = {
        let likesCount = UILabel()
        return likesCount
    }()
    
    private let likeButton: UIButton = {
        let likeButton = UIButton()
        likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        likeButton.tintColor = .systemRed
        return likeButton
    }()
    
    func configure(with cellImageName: String, label: String, likes: Int) {
        imageView.downloaded(from: cellImageName)
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 15.0
        title.text = label
        likesCount.text = String(likes)
        likesCount.textAlignment = .right
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        contentView.addSubview(title)
        contentView.addSubview(likeButton)
        contentView.addSubview(likesCount)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        imageView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            imageView.widthAnchor.constraint(equalTo: self.contentView.widthAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 190)
        ])
        
        title.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            title.widthAnchor.constraint(equalToConstant: 253),
            title.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        
        likeButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            likeButton.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            likeButton.widthAnchor.constraint(equalToConstant: 40),
            likeButton.heightAnchor.constraint(equalToConstant: 20),
            likeButton.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor)
        ])
        
        likeButton.addTarget(self, action: #selector(likeButtonPressed), for: .touchUpInside)
        
        likesCount.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            likesCount.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            likesCount.widthAnchor.constraint(equalToConstant: 60),
            likesCount.heightAnchor.constraint(equalToConstant: 20),
            likesCount.trailingAnchor.constraint(equalTo: likeButton.leadingAnchor)
        ])
        
    }
    
    @objc func likeButtonPressed() {
        
    }
}


extension UIImageView {
    func downloaded(from url: URL) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url)
    }
}
