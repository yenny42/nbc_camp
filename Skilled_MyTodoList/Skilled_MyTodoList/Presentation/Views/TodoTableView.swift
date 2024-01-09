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
    var dataList: [TodoData] = []
    
    // MARK: - UI Properties
    
    private let emptyDataTable: UILabel = {
        let label = UILabel()
        label.text = "작성된 Todo가 없습니다."
        label.textAlignment = .center
        label.textColor = .systemGray
        
        return label
    }()
    
    private let tableView: UITableView = UITableView()
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
     
        setDelegate()
        setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setTodoDataList(_ data: [TodoData]) {
        dataList = data
//        print(dataList)
    }
    
    func setTodoCategory(_ data: [String]) {
        dataCategory = Set(data).sorted()
    }
    
}

// MARK: - Extensions

extension TodoTableView {
    private func setUI() {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        
        [tableView].forEach { stackView.addArrangedSubview($0) }
        
        self.addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 50),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20),
        ])
        
//        title.heightAnchor.constraint(equalTo: stackView.heightAnchor, multiplier: 0.07).isActive = true
        tableView.heightAnchor.constraint(equalTo: stackView.heightAnchor, multiplier: 1).isActive = true
    }
}

// MARK: - UITableView Settings

extension TodoTableView: UITableViewDelegate, UITableViewDataSource {
    private func setDelegate() {
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataCategory.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let category = dataCategory[section]
        return dataList.filter { $0.category == category }.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.selectionStyle = .none
        
        let category = dataCategory[indexPath.section]
        let categoryItems = dataList.filter { $0.category == category }
        
        let todoItem = categoryItems[indexPath.row]
        
        if todoItem.isCompleted {
            cell.textLabel?.attributedText = todoItem.title.strikeThrough()
            cell.accessoryType = .checkmark
        } else {
            cell.textLabel?.text = todoItem.title
            cell.accessoryType = .disclosureIndicator
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return dataCategory[section]
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let editAction = UIContextualAction(style: .normal, title: "수정") { (_, _, completionHandler) in
            print("수정 버튼 눌림 - section: \(indexPath.section), row: \(indexPath.row)")
            
            completionHandler(true)
        }
        
        editAction.backgroundColor = .systemBlue
        editAction.image = UIImage(systemName: "pencil")
        
        let configuration = UISwipeActionsConfiguration(actions: [editAction])
        return configuration
    }

}
