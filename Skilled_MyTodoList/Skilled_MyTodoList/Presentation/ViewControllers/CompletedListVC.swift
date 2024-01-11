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
    var todoList: [(TodoData, key: String)] = []
    
    // MARK: - UI Properties
    
    let completedListView = CompletedListView()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadData()
    }
    
    func loadData() {
        let loadData = TodoData.loadAllData()
        
        var value: [(TodoData, key: String)] = []
        
        for data in loadData {
            if data.0.isCompleted == true {
                value.append(data)
            }
        }
        
        self.completedListView.setTodoData(value)
    }
}

// MARK: - Extensions

extension CompletedListVC {
    private func setUI() {
        view.backgroundColor = .systemGray6
        
        navigationItem.title = "⭐ 완료한 일 ⭐"
        
        view.addSubview(completedListView)
        
        completedListView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            completedListView.topAnchor.constraint(equalTo: view.topAnchor),
            completedListView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            completedListView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            completedListView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
