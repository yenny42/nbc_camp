//
//  TodoListVC.swift
//  Skilled_MyTodoList
//
//  Created by t2023-m0035 on 1/8/24.
//

import UIKit

class TodoListVC: UIViewController {
    
    let todoTableView = TodoTableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
    }
}

extension TodoListVC {
    private func setUI() {
        view.backgroundColor = .white
        view.addSubview(todoTableView)
        
        todoTableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            todoTableView.topAnchor.constraint(equalTo: view.topAnchor),
            todoTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            todoTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            todoTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
