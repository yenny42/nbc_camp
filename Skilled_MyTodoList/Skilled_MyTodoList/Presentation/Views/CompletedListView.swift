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
    var datas: [String: [(TodoData, key: String)]] = [:]
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.rowHeight = 44
        
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
     
        setDelegate()
        setUI()
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
