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
        
        setUI()
        setLayout()
    }
}

// MARK: - Extensions : UI & Laytout

extension ViewController {
    private func setUI() {
        view.backgroundColor = .white
        
        view.addSubview(profileButton)
        profileButton.addTarget(self, action: #selector(navigateToProfileDesignVC), for: .touchUpInside)
    }
    
    private func setLayout() {
        NSLayoutConstraint.activate([
            profileButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

// MARK: - Extensions : @objc method

extension ViewController {
    @objc private func navigateToProfileDesignVC() {
        self.navigationController?.pushViewController(profileDesignViewController, animated: true)
    }
}
