//
//  ViewController.swift
//  Deepening_Profile
//
//  Created by t2023-m0035 on 1/24/24.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - UI Properties
    
    private let profileDesignViewController = ProfileDesignViewController()
    
    private let mainImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.backgroundColor = .systemGray6
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    private let profileButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.setTitle("ProfileDesignViewController", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10
        button.contentEdgeInsets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        
        return button
    }()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setMainLogo()
        setUI()
        setLayout()
    }
}

// MARK: - Extensions : UI & Layout

extension ViewController {
    private func setUI() {
        view.backgroundColor = .white
        
        view.addSubview(mainImage)
        view.addSubview(profileButton)
        profileButton.addTarget(self, action: #selector(navigateToProfileDesignVC), for: .touchUpInside)
    }
    
    private func setLayout() {
        NSLayoutConstraint.activate([
            mainImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainImage.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            mainImage.widthAnchor.constraint(equalToConstant: 250),
            mainImage.heightAnchor.constraint(equalToConstant: 200),
            
            profileButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileButton.topAnchor.constraint(equalTo: mainImage.bottomAnchor, constant: 15)
        ])
    }
    
    private func setMainLogo() {
        ImageLoader.loadImage(from: "https://spartacodingclub.kr/css/images/scc-og.jpg", into: self.mainImage)
    }
}

// MARK: - Extensions : @objc method

extension ViewController {
    @objc private func navigateToProfileDesignVC() {
        profileDesignViewController.modalPresentationStyle = .fullScreen
        present(profileDesignViewController, animated: true)
    }
}
