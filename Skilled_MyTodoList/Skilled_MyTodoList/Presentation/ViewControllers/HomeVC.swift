//
//  HomeVC.swift
//  Skilled_MyTodoList
//
//  Created by t2023-m0035 on 1/9/24.
//

import UIKit

class HomeVC: UIViewController {
    
    // MARK: - Properties
    
    var dataList: [TodoData] = []
    
    // MARK: - UI Properties
    
    let homeView = HomeView()
    let todoListVC = TodoListVC()
    let completedListVC = CompletedListVC()
    let randomDogVC = RandomDogVC()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
    }
}

// MARK: - UIButton Action Methods

extension HomeVC {
    @objc private func didTapShowTodoButton() {
        self.navigationController?.pushViewController(todoListVC, animated: true)
    }
    
    @objc private func didTapShowCompletedButton() {
        self.navigationController?.pushViewController(completedListVC, animated: true)
    }
    
    @objc private func didTapShowRandomDogImageButton() {
        self.present(randomDogVC, animated: true)
    }
}

// MARK: - Extensions

extension HomeVC {
    private func setAddTarget() {
        homeView.showTodoListButton.addTarget(self, action: #selector(didTapShowTodoButton), for: .touchUpInside)
        homeView.showCompletedListButton.addTarget(self, action: #selector(didTapShowCompletedButton), for: .touchUpInside)
        homeView.showDogImage.addTarget(self, action: #selector(didTapShowRandomDogImageButton), for: .touchUpInside)
    }
    
    private func setUI() {
        setAddTarget()
        setMainImage()
        
        view.backgroundColor = .white
        view.addSubview(homeView)
        
        homeView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            homeView.topAnchor.constraint(equalTo: view.topAnchor),
            homeView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            homeView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            homeView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setMainImage() {
        ImageLoader.loadImage(from: "https://spartacodingclub.kr/css/images/scc-og.jpg", into: self.homeView.mainImage)
    }
}
