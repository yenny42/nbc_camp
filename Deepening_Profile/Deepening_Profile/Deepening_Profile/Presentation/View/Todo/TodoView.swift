//
//  TodoView.swift
//  Deepening_Profile
//
//  Created by t2023-m0035 on 1/25/24.
//

import UIKit

class TodoView: UIView {
    
    var categoryTitle: String = ""
    
    // MARK: - View Model
    
    private let viewModel: TodoViewModel
    
    // MARK: - UI Properties
    
    private lazy var todayLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.text = "오늘 날짜 : \(viewModel.dateFormat(Date()))"
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
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.setTitle("추가", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 4
        
        return button
    }()
    
    lazy var todoList: TodoCollectionView = {
        let todoCollectionView = TodoCollectionView(viewModel: viewModel)
        todoCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return todoCollectionView
    }()

    lazy var studyButton = createCategoryButton(title: "공부", color: .systemBlue)
    lazy var houseWorkButton = createCategoryButton(title: "집안일", color: .systemPink)
    lazy var exerciseButton = createCategoryButton(title: "운동", color: .systemGreen)

    lazy var category: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [studyButton, houseWorkButton, exerciseButton])
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .leading
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    // MARK: - Life Cycle

    init(viewModel: TodoViewModel) {
        self.viewModel = viewModel
        
        super.init(frame: .zero)
        
        setUI()
        setLayout()
        setAddTarget()
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
        
        [category, titleTextField, addButton].forEach {
            self.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            titleTextField.topAnchor.constraint(equalTo: self.todayLabel.bottomAnchor, constant: 15),
            titleTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            titleTextField.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8, constant: -15),
            
            addButton.topAnchor.constraint(equalTo: self.todayLabel.bottomAnchor, constant: 15),
            addButton.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            addButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.2),
            
            category.topAnchor.constraint(equalTo: self.titleTextField.bottomAnchor, constant: 15),
            category.leadingAnchor.constraint(equalTo: self.leadingAnchor),
        ])
        
        // MARK: Todo List CollectionView
        
        self.addSubview(todoList)
        
        NSLayoutConstraint.activate([
            todoList.topAnchor.constraint(equalTo: self.addButton.bottomAnchor, constant: 70),
            todoList.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            todoList.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            todoList.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension TodoView {
    private func setAddTarget() {
        studyButton.addTarget(self, action: #selector(categoryButtonTapped), for: .touchUpInside)
        houseWorkButton.addTarget(self, action: #selector(categoryButtonTapped), for: .touchUpInside)
        exerciseButton.addTarget(self, action: #selector(categoryButtonTapped), for: .touchUpInside)
    }
    
    @objc
    func categoryButtonTapped(_ sender: UIButton) {
        for button in [studyButton, houseWorkButton, exerciseButton] {
            button.backgroundColor = .clear
            button.layer.borderWidth = 1
            button.setTitleColor(button.layer.borderColor != nil ? UIColor(cgColor: button.layer.borderColor!) : .black, for: .normal)
        }

        sender.backgroundColor = sender.currentTitleColor
        sender.layer.borderWidth = 0
        sender.setTitleColor(.white, for: .normal)
        
        self.categoryTitle = (sender.titleLabel?.text)!
    }
}
