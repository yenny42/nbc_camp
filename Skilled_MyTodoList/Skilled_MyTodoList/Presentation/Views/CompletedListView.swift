//
//  CompletedListView.swift
//  Skilled_MyTodoList
//
//  Created by t2023-m0035 on 1/10/24.
//

import UIKit

final class CompletedListView: UIView {
    
    // MARK: - Properties
    
    var dataCategory: [String] = []
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
        setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Data Setting

    func setTodoData(_ data: [(TodoData, key: String)]) {
        var groupedData: [String: [(TodoData, key: String)]] = [:]
        
        dataCategory = Set(data.map { $0.0.category }).sorted()
        
        for category in dataCategory {
            let sectionData = data.filter { $0.0.category == category }
            groupedData[category] = sectionData
        }
        
        datas = groupedData
        
        tableView.reloadData()
    }
}

// MARK: - Extensions

extension CompletedListView {
    private func setUI() {
        self.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
}

// MARK: - TableView Setting Extensions

extension CompletedListView: UITableViewDelegate, UITableViewDataSource {
    private func setDelegate() {
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CompletedCell")
    }
    
    // MARK: Section
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return dataCategory[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let category = dataCategory[section]
        return datas[category]?.count ?? 0
    }
    
    // MARK: Cell
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataCategory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CompletedCell", for: indexPath)
        cell.selectionStyle = .none
        
        let category = dataCategory[indexPath.section]
        if let sectionData = datas[category] {
            let completedItem = sectionData[indexPath.row]
            
            if completedItem.0.isCompleted {
                cell.textLabel?.text = completedItem.0.title
                cell.accessoryType = .checkmark
            }
        }
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "삭제") { (_, _, completionHandler) in
            let category = self.dataCategory[indexPath.section]
            
            let selectedData = self.datas[category]
            if let deletedData = selectedData?[indexPath.row] {
                TodoData.removeTodoData(forKey: deletedData.key)
            }
            
            self.datas[category]?.remove(at: indexPath.row)
            
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
