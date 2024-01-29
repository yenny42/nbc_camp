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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        todoView.todoList.getTodoData()
        DispatchQueue.main.async {
            self.todoView.todoList.reloadData()
        }
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
        todoView.addButton.addTarget(self, action: #selector(didTapAddTodoButton), for: .touchUpInside)
        todoView.todoList.navigateToTodoDetail = navigateToDetailVC(selectedItem:)
    }
    
    @objc
    private func didTapAddTodoButton() {
        if todoView.titleTextField.text?.count != 0 {
            let title = todoView.titleTextField.text!
            
            if todoView.titleTextField.text!.count > 30 {
                maxinumStringAlert(in: self)
            } else {
                viewModel.saveData(title: title)
            }
            
            todoView.updateUI()
            
        } else {
            actionAlert(in: self, title: "내용을 입력해주세요.", message: "", cancelButton: false)
        }
    }
    
    func navigateToDetailVC(selectedItem: Todo) {
        let todoDetailViewController = TodoDetailViewController(data: selectedItem, viewModel: viewModel)
        self.navigationController?.pushViewController(todoDetailViewController, animated: true)
    }
}
