//
//  TodoViewController.swift
//  Deepening_Profile
//
//  Created by t2023-m0035 on 1/25/24.
//

import UIKit

class TodoViewController: UIViewController {
    
    // MARK: - View Model
    
    private lazy var viewModel = TodoViewModel()
    
    // MARK: - Properties
    
    private var todoList: [Todo]?
    
    // MARK: - UI Properties
    
    private lazy var todoView = TodoView(viewModel: viewModel)
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setAddTarget()
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

extension TodoViewController {
    private func setAddTarget() {
        todoView.addButton.addTarget(self, action: #selector(navigateToDetailTodo), for: .touchUpInside)
    }
    
    @objc
    private func navigateToDetailTodo() {
        if todoView.titleTextField.text?.count != 0 {
            let title = todoView.titleTextField.text!
            
            viewModel.saveData(title: title)
            
            todoView.updateData()
            
        } else {
            print("할 일을 입력해주세요 alert창 띄우기")
        }
    }
}
