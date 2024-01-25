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
    
    private let level1Button: CustomButton = {
        let button = CustomButton(text: "Lv.1 : ProfileDesignVC", backgroundColor: .systemPink)
        return button
    }()
    
    private let level2Button: CustomButton = {
        let button = CustomButton(text: "Lv.2 : ProfileVC", backgroundColor: .systemTeal)
        return button
    }()
    
    private let level3Button: CustomButton = {
        let button = CustomButton(text: "Lv.3 : Core Data", backgroundColor: .systemIndigo)
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
        
        [mainImage, level1Button, level2Button, level3Button].forEach {
            view.addSubview($0)
        }
        
        level1Button.addTarget(self, action: #selector(navigateToProfileDesignVC), for: .touchUpInside)
    }
    
    private func setLayout() {
        NSLayoutConstraint.activate([
            
            mainImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            mainImage.widthAnchor.constraint(equalToConstant: 250),
            mainImage.heightAnchor.constraint(equalToConstant: 200),
            
            level1Button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            level1Button.topAnchor.constraint(equalTo: mainImage.bottomAnchor, constant: 30),
            
            level2Button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            level2Button.topAnchor.constraint(equalTo: level1Button.bottomAnchor, constant: 15),
            
            level3Button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            level3Button.topAnchor.constraint(equalTo: level2Button.bottomAnchor, constant: 15),
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
