//
//  CompletedListVC.swift
//  Skilled_MyTodoList
//
//  Created by t2023-m0035 on 1/9/24.
//

import UIKit

class CompletedListVC: UIViewController {
    
    // MARK: - Properties
    
    var todoCategory: [String] = []
    var todoList: [TodoData] = []
    
    let tableView = UITableView()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadAllTodoData()
        setDelegate()
        setUI()
     }
    
    func loadAllTodoData() {
        let allUserDefaults = UserDefaults.standard.dictionaryRepresentation()
        var category: [String] = []

        for (key, _) in allUserDefaults {
            if let savedData = UserDefaults.standard.object(forKey: key) as? Data {
                let decoder = JSONDecoder()
                if let savedObject = try? decoder.decode(TodoData.self, from: savedData) {
//                    todoCategory.append(savedObject.category)
//                    todoList.append(savedObject)
                    
                    if savedObject.isCompleted == true {
                        print(savedObject)
                        category.append(savedObject.category)
                        todoList.append(savedObject)
                    }
                }
            }
        }
        todoCategory = Set(category).sorted()
    }
}

extension CompletedListVC {
    private func setUI() {
        view.backgroundColor = .white
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}


extension CompletedListVC: UITableViewDelegate, UITableViewDataSource {
    private func setDelegate() {
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CompletedCell")
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return todoCategory.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let category = todoCategory[section]
        return todoList.filter { $0.category == category }.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CompletedCell", for: indexPath)
        cell.selectionStyle = .none
        
        let category = todoCategory[indexPath.section]
        let categoryItems = todoList.filter { $0.category == category }
        
        let todoItem = categoryItems[indexPath.row]
        
        if todoItem.isCompleted {
            cell.textLabel?.text = todoItem.title
            cell.accessoryType = .checkmark
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return todoCategory[section]
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let editAction = UIContextualAction(style: .normal, title: "삭제") { (_, _, completionHandler) in
            print("삭제 버튼 눌림 - section: \(indexPath.section), row: \(indexPath.row)")
            
            completionHandler(true)
        }
        
        editAction.backgroundColor = .systemRed
        editAction.image = UIImage(systemName: "trash")
        
        let configuration = UISwipeActionsConfiguration(actions: [editAction])
        return configuration
    }
}
