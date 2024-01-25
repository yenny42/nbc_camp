//
//  TodoViewController.swift
//  Deepening_Profile
//
//  Created by t2023-m0035 on 1/25/24.
//

import UIKit

class TodoViewController: UIViewController {
    
    // MARK: - UI Properties
    
    let todoView = TodoView()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setLayout()
    }
}

// MARK: - Extensions

extension TodoViewController {
    private func setUI() {
        view.backgroundColor = .white
        self.title = "To Do"
    }
    
    private func setLayout() {
        todoView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(todoView)
        NSLayoutConstraint.activate([
            todoView.topAnchor.constraint(equalTo: view.topAnchor),
            todoView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            todoView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            todoView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}
