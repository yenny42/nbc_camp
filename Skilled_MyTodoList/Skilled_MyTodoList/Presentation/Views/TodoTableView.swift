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
    var test: [String: [(TodoData, key: String)]] = [:]
    
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
        
        
        // 섹션별로 데이터를 그룹화하는 딕셔너리
        var groupedData: [String: [(TodoData, key: String)]] = [:]
        
        for category in dataCategory {
            // 해당 카테고리에 속하는 데이터 필터링
            let sectionData = dataList.filter { $0.0.category == category }
            groupedData[category] = sectionData
        }
        
        // 딕셔너리의 값을 통합하여 테이블 뷰에 표시될 데이터 설정
        dataList = groupedData.flatMap { $0.value }
        
        // 디버깅을 위한 출력
        print(dataList)
        print(dataCategory)
        print("====================")
        //        for (category, sectionData) in groupedData {
        //            print("\(category): \(sectionData)")
        //        }
        test = groupedData
        print(test)
        
        
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
        return test[category]?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TodoTableViewCell.identifier, for: indexPath) as! TodoTableViewCell
        cell.selectionStyle = .none
        
        let category = dataCategory[indexPath.section]
        if let sectionData = test[category] {
            let todoItem = sectionData[indexPath.row]
            
            cell.textLabel?.text = todoItem.0.title
            if todoItem.0.isCompleted == true {
                cell.textLabel?.textColor = .systemGray2
                cell.isCompleted.isOn = true
            } else {
                cell.isCompleted.isOn = false
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "삭제") { (_, _, completionHandler) in
            self.deleteRow(at: indexPath)
            completionHandler(true)
        }

        deleteAction.backgroundColor = .systemRed
        deleteAction.image = UIImage(systemName: "trash")

        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        return configuration
    }
    
    private func deleteRow(at indexPath: IndexPath) {
        let category = dataCategory[indexPath.section]
        
        if var sectionData = test[category] {
            let deletedItem = sectionData.remove(at: indexPath.row)
            test[category] = sectionData

            TodoData.removeUserDefaults(forKey: deletedItem.key)
            
            tableView.reloadData()
        }
    }
    
}
