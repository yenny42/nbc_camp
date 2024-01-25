//
//  ProfileDesignView.swift
//  Deepening_Profile
//
//  Created by t2023-m0035 on 1/24/24.
//

import UIKit

class ProfileDesignView: UIView{
    
    // MARK: - UI Properties
    
    private lazy var userID: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.text = "nabaecamp"
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 16)
        
        return label
    }()
    
    private lazy var menuButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.setImage(UIImage(named: "Menu"), for: .normal)
        
        return button
    }()
    
    private lazy var userImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "Ellipse"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    private lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.text = "르탄이\niOS Developer 🍎 \nspartacodingclub.kr"
        label.numberOfLines = 0
        
        return label
    }()
    
    private lazy var post: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        let count = UILabel()
        count.text = "100"
        
        let title = UILabel()
        title.text = "post"
        
        [count, title].forEach {
            stackView.addArrangedSubview($0)
        }
        
        return stackView
    }()
    
    private lazy var follower: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        let count = UILabel()
        count.text = "200"
        
        let title = UILabel()
        title.text = "follower"
        
        [count, title].forEach {
            stackView.addArrangedSubview($0)
        }
        
        return stackView
    }()
    
    private lazy var following: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        let count = UILabel()
        count.text = "300"
        
        let title = UILabel()
        title.text = "following"
        
        [count, title].forEach {
            stackView.addArrangedSubview($0)
        }
        
        return stackView
    }()
    
    private lazy var followButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        button.setTitle("Follow", for: .normal)
        button.layer.cornerRadius = 4
        button.backgroundColor = .systemBlue
        
        button.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        return button
    }()
    
    private lazy var messageButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        button.setTitle("Message", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 4
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemGray3.cgColor
        
        return button
    }()
    
    private lazy var moreButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 30).isActive = true
        button.widthAnchor.constraint(equalTo: button.heightAnchor).isActive = true
        
        button.setImage(UIImage(named: "More"), for: .normal)
        button.layer.cornerRadius = 4
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemGray3.cgColor
        
        return button
    }()
    
    private lazy var galleryNav: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        stackView.spacing = 0
        stackView.backgroundColor = .systemGray6
        
        let imageView = UIImageView(image: UIImage(named: "Grid"))
        imageView.contentMode = .scaleAspectFit
        
        let imageView2 = UIImageView(image: UIImage(systemName: ""))
        let imageView3 = UIImageView(image: UIImage(systemName: ""))
        
        [imageView, imageView2, imageView3].forEach {
            stackView.addArrangedSubview($0)
        }
        
        return stackView
    }()

    private lazy var galleryView: GalleryCollectionView = {
        let galleryView = GalleryCollectionView()
        galleryView.translatesAutoresizingMaskIntoConstraints = false
        return galleryView
    }()
    
    private lazy var navigationBar: UINavigationBar = {
        let imageView = UIImageView(image: UIImage(systemName: "person.fill"))
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: 0, y: 0, width: 22.5, height: 22.75)
        
        let navigationItem = UINavigationItem()
        navigationItem.titleView = imageView
        navigationItem.titleView?.tintColor = .black
        
        let navigationBar = UINavigationBar()
        navigationBar.items = [navigationItem]
        
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        
        return navigationBar
    }()
    
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Extensions : UI & Layout

extension ProfileDesignView {
    private func setUI() {
        self.backgroundColor = .white
        
        setUserId()
        setMenuButton()
        setProfile()
        setUserActivity()
        setButtons()
        setGalleryNav()
        setGallery()
        setNavBar()
    }
    
    private func setUserId() {
        self.addSubview(userID)
        NSLayoutConstraint.activate([
            userID.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10),
            userID.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        ])
    }
    
    private func setMenuButton() {
        self.addSubview(menuButton)
        NSLayoutConstraint.activate([
            menuButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10),
            menuButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16)
        ])
    }
    
    private func setProfile() {
        [userImage, infoLabel].forEach {
            self.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            userImage.topAnchor.constraint(equalTo: self.menuButton.bottomAnchor, constant: 17.5),
            userImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 14),
            
            infoLabel.topAnchor.constraint(equalTo: self.userImage.bottomAnchor, constant: 14),
            infoLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
        ])
    }
    
    private func setUserActivity() {
        [post, follower, following].forEach {
            self.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            post.trailingAnchor.constraint(equalTo: self.follower.leadingAnchor, constant: -20),
            follower.trailingAnchor.constraint(equalTo: self.following.leadingAnchor, constant: -15),
            following.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30),
            
            post.topAnchor.constraint(equalTo: self.menuButton.bottomAnchor, constant: 41),
            follower.topAnchor.constraint(equalTo: self.menuButton.bottomAnchor, constant: 41),
            following.topAnchor.constraint(equalTo: self.menuButton.bottomAnchor, constant: 41),
        ])
    }
    
    private func setButtons() {
        [followButton, messageButton, moreButton].forEach {
            self.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            followButton.topAnchor.constraint(equalTo: self.infoLabel.bottomAnchor, constant: 15),
            messageButton.topAnchor.constraint(equalTo: self.infoLabel.bottomAnchor, constant: 15),
            moreButton.topAnchor.constraint(equalTo: self.infoLabel.bottomAnchor, constant: 15),
            
            followButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            followButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5, constant: -45),
            
            messageButton.leadingAnchor.constraint(equalTo: followButton.trailingAnchor, constant: 15),
            messageButton.widthAnchor.constraint(equalTo: followButton.widthAnchor),
            
            moreButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15),
        ])
    }
    
    private func setGalleryNav() {
        self.addSubview(galleryNav)
        NSLayoutConstraint.activate([
            galleryNav.topAnchor.constraint(equalTo: self.moreButton.bottomAnchor, constant: 50),
            galleryNav.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            galleryNav.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
    }
    
    private func setGallery() {
        self.addSubview(galleryView)
        NSLayoutConstraint.activate([
            galleryView.topAnchor.constraint(equalTo: self.galleryNav.bottomAnchor, constant: 0),
            galleryView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            galleryView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            galleryView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -85),
        ])
    }
    
    
    private func setNavBar() {
        self.addSubview(navigationBar)
        NSLayoutConstraint.activate([
            navigationBar.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -44),
            navigationBar.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            navigationBar.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
    }
}
