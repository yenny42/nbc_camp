//
//  ProfileDesignView.swift
//  Deepening_Profile
//
//  Created by t2023-m0035 on 1/24/24.
//

import UIKit

class ProfileDesignView: UIView {
    
    // MARK: - UI Properties
    
    let userID: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.text = "nabaecamp"
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 16)
        
        return label
    }()
    
    let menuButton: UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.setImage(UIImage(named: "Menu"), for: .normal)
        
        return button
    }()
    
    let userImage: UIImageView = {
       let imageView = UIImageView(image: UIImage(named: "Ellipse"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.contentMode = .scaleAspectFit

        return imageView
    }()
    
    let infoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.text = "르탄이\niOS Developer 🍎 \nspartacodingclub.kr"
        label.numberOfLines = 0
        
        return label
    }()
    
    let navigationBar: UINavigationBar = {
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
    
    let post: UIStackView = {
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
    
    let follower: UIStackView = {
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

    let following: UIStackView = {
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
    
    private func setNavGallery() {
        
    }
    
    private func setNavBar() {
        self.addSubview(navigationBar)
        NSLayoutConstraint.activate([
            navigationBar.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            navigationBar.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            navigationBar.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            navigationBar.heightAnchor.constraint(equalToConstant: 0),
        ])
    }
}
