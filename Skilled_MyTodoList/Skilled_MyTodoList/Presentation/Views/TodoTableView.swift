//
//  TodoTableView.swift
//  Skilled_MyTodoList
//
//  Created by t2023-m0035 on 1/9/24.
//

import UIKit

class TodoTableView: UIView {
    
    // MARK: - Properties
    
    var dataCategory: [String] = []
    var dataList: [(TodoData, key: String)] = []
    var datas: [String: [(TodoData, key: String)]] = [:]
    
    // MARK: - UI Properties
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.rowHeight = 44
        
        return tableView
    }()
    
    // MARK: - Life Cycle
    
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
    
    func setTodoData(_ data: [(TodoData, key: String)], _ category: [String]) {
        dataList = data
        dataCategory = Set(category.map { $0.lowercased() }).sorted()
        
        var groupedData: [String: [(TodoData, key: String)]] = [:]
        
        for category in dataCategory {
            let sectionData = dataList.filter { $0.0.category == category }
            groupedData[category] = sectionData
        }
        
        dataList = groupedData.flatMap { $0.value }
        datas = groupedData
        
        tableView.reloadData()
    }
}

// MARK: - Extensions

extension TodoTableView {
    private func setUI() {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        
        stackView.addArrangedSubview(tableView)
        
        self.addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
}

extension TodoTableView: TodoListDelegate {
    func didTapSwitch(isOn: Bool, indexPath: IndexPath) {
        let category = dataCategory[indexPath.section]
        let selectedData = datas[category]
        var updatedData = selectedData![indexPath.row]
        updatedData.0.isCompleted = isOn
        
        TodoData.updateTodoData(value: updatedData.0, forKey: updatedData.key)
        
        datas[category]![indexPath.row] = (updatedData.0, key: updatedData.key)
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
}



// MARK: - UITableView Settings

extension TodoTableView: UITableViewDelegate, UITableViewDataSource {
    private func setDelegate() {
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(TodoTableViewCell.self, forCellReuseIdentifier: TodoTableViewCell.identifier)
    }
    
    
    // MARK: - Section
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataCategory.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return dataCategory[section]
    }
    
    // MARK: - Row Cell
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let category = dataCategory[section]
        return datas[category]?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TodoTableViewCell.identifier, for: indexPath) as! TodoTableViewCell
        cell.selectionStyle = .none
        cell.delegate = self
        cell.indexPath = indexPath
        
        let category = dataCategory[indexPath.section]
        if let sectionData = datas[category] {
            let todoItem = sectionData[indexPath.row]
            
            cell.textLabel?.text = todoItem.0.title
            if todoItem.0.isCompleted == true {
                cell.textLabel?.textColor = .systemGray2
                cell.isCompleted.isOn = true
            } else {
                cell.textLabel?.textColor = .black
                cell.isCompleted.isOn = false
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "삭제") { (_, _, completionHandler) in
            let category = self.dataCategory[indexPath.section]
            
            // 유저디폴트에서 삭제
            let selectedData = self.datas[category]
            if let deletedData = selectedData?[indexPath.row] {
                TodoData.removeTodoData(forKey: deletedData.key)
            }
            
            // dataList에서 삭제
            self.datas[category]?.remove(at: indexPath.row)
            self.dataList = self.datas.flatMap { $0.value }
            
            print(self.dataList)
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
            
            completionHandler(true)
        }

        deleteAction.backgroundColor = .systemRed
        deleteAction.image = UIImage(systemName: "trash")

        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        return configuration
    }
    
}
