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
    
    private lazy var randomButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(" 🎲 RANDOM 🎲 ", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .systemGray6
        button.layer.cornerRadius = 10
        
        button.addTarget(self, action: #selector(changeAge), for: .touchUpInside)
        
        return button
    }()
    
    // MARK: - ViewModel
    
    var viewModel: ProfileViewModel
    
    init(viewModel: ProfileViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel.delegate = self
        
        bindingViewModel()
        setUI()
    }
}

// MARK: - Extensions UI & Data Binding

extension ProfileViewController {
    private func setUI() {
        view.backgroundColor = .white
        
        [nameLabel, ageLabel, randomButton].forEach {
            view.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            ageLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            ageLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            ageLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            randomButton.topAnchor.constraint(equalTo: ageLabel.bottomAnchor, constant: 30),
            randomButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
}

extension ProfileViewController: UserViewModel {
    @objc
    func changeAge() {
        viewModel.userAge = Int.random(in: 0 ..< 100)
    }
    
    func updateUserName(name: String) {
        DispatchQueue.main.async {
            self.nameLabel.text = name
        }
    }
    
    func updateUserAge(age: Int) {
        DispatchQueue.main.async {
            self.ageLabel.text = String(age)
        }
    }
    
    private func bindingViewModel() {
        DispatchQueue.main.async {
            self.nameLabel.text = self.viewModel.userName
            self.ageLabel.text = String(self.viewModel.userAge)
        }
    }
}
