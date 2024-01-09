//
//  TodoListVC.swift
//  Skilled_MyTodoList
//
//  Created by t2023-m0035 on 1/8/24.
//

import UIKit

class TodoListVC: UIViewController {
    
    // MARK: - Properties
    
    var todoCategory: [String] = []
    var todoList: [TodoData] = []
    
    // MARK: - UI Properties
    
    let todoTableView = TodoTableView()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadAllTodoData()
        
        self.todoTableView.setTodoDataList(todoList)
        self.todoTableView.setTodoCategory(todoCategory)
    }
    
    func saveTodoData(_ data: TodoData) {
        let encoder = JSONEncoder()

        if let encoded = try? encoder.encode(data) {
            UserDefaults.standard.setValue(encoded, forKey: String(describing: UUID()))
        }
    }
    
    func loadAllTodoData() {
        let allUserDefaults = UserDefaults.standard.dictionaryRepresentation()

        for (key, _) in allUserDefaults {
            if let savedData = UserDefaults.standard.object(forKey: key) as? Data {
                let decoder = JSONDecoder()
                if let savedObject = try? decoder.decode(TodoData.self, from: savedData) {
                    todoCategory.append(savedObject.category)
                    todoList.append(savedObject)
                }
            }
        }

    }
}

// MARK: - Extensions

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
