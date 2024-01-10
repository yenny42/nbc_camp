//
//  CompletedListView.swift
//  Skilled_MyTodoList
//
//  Created by t2023-m0035 on 1/10/24.
//

import UIKit

class CompletedListView: UIView {
    
    var dataCategory: [String] = []
    var dataList: [(TodoData, key: String)] = []
    
    let tableView = UITableView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
     
        setDelegate()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setTodoDataList(_ data: [(TodoData, key: String)]) {
        dataList = data
    }
    
    func setTodoCategory(_ data: [String]) {
        dataCategory = Set(data).sorted()
    }
}

extension CompletedListView {
    private func setUI() {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        
        stackView.addArrangedSubview(tableView)
        
        self.addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 50),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20),
        ])
        
        tableView.heightAnchor.constraint(equalTo: stackView.heightAnchor, multiplier: 1).isActive = true
    }
}

extension CompletedListView: UITableViewDelegate, UITableViewDataSource {
    private func setDelegate() {
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CompletedCell")
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataCategory.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let category = dataCategory[section]
        return dataList.filter { $0.0.category == category }.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CompletedCell", for: indexPath)
        cell.selectionStyle = .none
        
        let category = dataCategory[indexPath.section]
        let categoryItems = dataList.filter { $0.0.category == category }
        
        let todoItem = categoryItems[indexPath.row]
        
        if todoItem.0.isCompleted {
            cell.textLabel?.text = todoItem.0.title
            cell.accessoryType = .checkmark
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return dataCategory[section]
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
