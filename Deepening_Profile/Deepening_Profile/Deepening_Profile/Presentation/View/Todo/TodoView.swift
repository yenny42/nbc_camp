//
//  TodoView.swift
//  Deepening_Profile
//
//  Created by t2023-m0035 on 1/25/24.
//

import UIKit

class TodoView: UIView {
    
    // MARK: - View Model
    
//    private let viewModel: TodoViewModel
    
    // MARK: - UI Properties
    
    private lazy var todayLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.text = "오늘 날짜 : \(TaskManager.dateFormat(Date()))"
        label.font = UIFont.systemFont(ofSize: 16)
        
        return label
    }()
    
    lazy var titleTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        textField.placeholder = "할 일을 입력해주세요"
        
        textField.borderStyle = .roundedRect
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.systemGray3.cgColor
        textField.layer.cornerRadius = 4
        
        return textField
    }()
    
    lazy var addButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.setTitle("추가", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 4
        
        return button
    }()
    
    lazy var todoList: TodoCollectionView = {
        let todoCollectionView = TodoCollectionView()
        todoCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return todoCollectionView
    }()
    
    // MARK: - Life Cycle

//    override func viewDidLoad() {
//        super.viewDidLoad()
//     
//        setUI()
//        setLayout()
//    }
    
    init() {
//        self.viewModel = viewModel
        
        super.init(frame: .zero)
        
        setUI()
        setLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateUI() {
        titleTextField.text = ""
        todoList.getTodoData()
    }
}

// MARK: - Extensions

extension TodoView {
    private func setUI() {
        self.backgroundColor = .white
    }
    
    private func setLayout() {
        
        // MARK: Today Date Label
        
        self.addSubview(todayLabel)
        
        NSLayoutConstraint.activate([
            todayLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 15),
            todayLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 3)
        ])
        
        // MARK: Todo TextField, Add Button
        
        [titleTextField, addButton].forEach {
            self.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            titleTextField.topAnchor.constraint(equalTo: self.todayLabel.bottomAnchor, constant: 15),
            titleTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            titleTextField.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8, constant: -15),
            
            addButton.topAnchor.constraint(equalTo: self.todayLabel.bottomAnchor, constant: 15),
            addButton.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            addButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.2),
        ])
        
        // MARK: Todo List CollectionView
        
        self.addSubview(todoList)
        
        NSLayoutConstraint.activate([
            todoList.topAnchor.constraint(equalTo: self.addButton.bottomAnchor, constant: 30),
            todoList.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            todoList.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            todoList.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
