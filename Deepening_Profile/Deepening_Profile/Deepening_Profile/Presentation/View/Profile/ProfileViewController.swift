//
//  ProfileViewController.swift
//  Deepening_Profile
//
//  Created by t2023-m0035 on 1/25/24.
//

import UIKit

class ProfileViewController: UIViewController {
    
    // MARK: - UI Properties
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        
        return label
    }()
    
    private lazy var ageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .gray
        
        return label
    }()
    
    // MARK: - ViewModel
    
    var viewModel: ProfileViewModel?
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        bindingViewModel()
    }
}

// MARK: - Extensions UI & Data Binding

extension ProfileViewController {
    private func setUI() {
        view.backgroundColor = .white
        
        [nameLabel, ageLabel].forEach {
            view.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -20),
            
            ageLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            ageLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    private func bindingViewModel() {
        guard let viewModel = viewModel else { return }
        
        DispatchQueue.main.async {
            self.nameLabel.text = viewModel.userName
            self.ageLabel.text = viewModel.userAge
        }
    }
}
