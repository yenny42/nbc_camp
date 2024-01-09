//
//  HomeVC.swift
//  Skilled_MyTodoList
//
//  Created by t2023-m0035 on 1/9/24.
//

import UIKit

class HomeVC: UIViewController {
    
    let todoListVC = TodoListVC()
    let homeView = HomeView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setAddTarget()
        
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
 
    @objc private func didTapShowTodoButton() {
        self.navigationController?.pushViewController(todoListVC, animated: true)
    }
    
    private func setAddTarget() {
        homeView.goButton.addTarget(self, action: #selector(didTapShowTodoButton), for: .touchUpInside)
    }
}
