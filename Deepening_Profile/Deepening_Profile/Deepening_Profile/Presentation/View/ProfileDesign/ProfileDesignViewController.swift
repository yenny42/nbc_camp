//
//  ProfileDesignViewController.swift
//  Deepening_Profile
//
//  Created by t2023-m0035 on 1/24/24.
//

import UIKit

class ProfileDesignViewController: UIViewController {
    
    let profileDesignView = ProfileDesignView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
    }
}

extension ProfileDesignViewController {
    private func setUI() {
        view.backgroundColor = .white
        
        profileDesignView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(profileDesignView)
        NSLayoutConstraint.activate([
            profileDesignView.topAnchor.constraint(equalTo: view.topAnchor),
            profileDesignView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            profileDesignView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            profileDesignView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
