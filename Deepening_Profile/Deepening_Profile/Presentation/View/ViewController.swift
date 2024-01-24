//
//  ViewController.swift
//  Deepening_Profile
//
//  Created by t2023-m0035 on 1/24/24.
//

import UIKit

class ViewController: UIViewController {
    
    private let gotoProfilePage: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.setTitle("ProfileDesignViewController", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10
        button.contentEdgeInsets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setLayout()
    }
}

extension ViewController {
    private func setUI() {
        view.backgroundColor = .white
        
        view.addSubview(gotoProfilePage)
    }
    
    private func setLayout() {
        NSLayoutConstraint.activate([
            gotoProfilePage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            gotoProfilePage.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
