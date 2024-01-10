//
//  TodoListVC.swift
//  Skilled_MyTodoList
//
//  Created by t2023-m0035 on 1/8/24.
//

import UIKit

class TodoListVC: UIViewController {
    
    // MARK: - UI Properties
    
    let todoTableView = TodoTableView()
    
    lazy var addButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        button.tag = 1
        
        return button
    }()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadData()
    }
    
    func loadData() {
        let loadData = TodoData.loadAllData()
        
        var category: [String] = []
    
        for data in loadData {
            category.append(data.0.category)
        }
        
        self.todoTableView.setTodoData(loadData, category)
    }
}

// MARK: - Extensions

extension TodoListVC {
    @objc private func addButtonTapped() {
        let alert = UIAlertController(title: "To Do", message: "할 일을 추가하세요.", preferredStyle: .alert)
        
        alert.addTextField() { (textField) in
            textField.placeholder = "카테고리를 입력해주세요"
        }
        alert.addTextField() { (textField) in
            textField.placeholder = "할 일을 입력해주세요"
        }
        
        alert.addAction(UIAlertAction(title: NSLocalizedString("CANCEL", comment: "cancel action"), style: .destructive))
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
            let category = alert.textFields?[0].text
            let title = alert.textFields?[1].text
            
            TodoData.saveTodoData(TodoData(category: category!, title: title!, isCompleted: false))
            self.loadData()
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
}

extension TodoListVC {
    private func setUI() {
        view.backgroundColor = .white
        
        navigationItem.rightBarButtonItem = addButton
        navigationItem.title = "👻 할 일 목록 👻"
        
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
