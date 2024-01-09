//
//  TodoTableView.swift
//  Skilled_MyTodoList
//
//  Created by t2023-m0035 on 1/9/24.
//

import UIKit

class TodoTableView: UIView {
    
    // MARK: - UI Properties
    
    private let title: UILabel = {
        let label = UILabel()
        label.text = "To Do List"
        label.font = UIFont.systemFont(ofSize: 25)
        label.textAlignment = .center
        
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
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            return 2
        } else {
            return 3
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.selectionStyle = .none
        
        if indexPath.section == 0 {
            cell.textLabel?.text = "test"
            
            return cell
            
        } else if indexPath.section == 1 {
            cell.textLabel?.text = "test2"
            
            return cell
            
        } else {
            cell.textLabel?.text = "test3"
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "section \(section+1)"
    }
    
}
