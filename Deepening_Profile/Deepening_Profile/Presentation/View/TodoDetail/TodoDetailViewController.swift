//
//  TodoDetailViewController.swift
//  Deepening_Profile
//
//  Created by t2023-m0035 on 1/26/24.
//

import UIKit

class TodoDetailViewController: UIViewController {
    
    // MARK: - Properties
    
    private var data: Todo
    private var viewModel: TodoViewModel
    
    // MARK: - UI Properties
    
    private lazy var createDate: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.text = "등록일 : \(String(describing: viewModel.dateFormat(data.createDate)))"
        
        return label
    }()
    
    private lazy var modifyDate: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        if let modifyDate = data.modifyDate {
            let formattedDate = viewModel.dateFormat(modifyDate)
            label.text = "수정일 : \(String(describing: formattedDate))"
        } else {
            label.text = "수정일 : -"
        }

        return label
    }()
    
    private lazy var checkButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.setImage(UIImage(systemName: "checkmark.bubble"), for: .normal)
        button.tintColor = .systemGray2
        
        return button
    }()
    
    private lazy var titleTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        let screenHeight = UIScreen.main.bounds.height
        let heightRatio: CGFloat = 0.5
        textField.heightAnchor.constraint(equalToConstant: screenHeight * heightRatio).isActive = true
        
        textField.text = data.title
        textField.borderStyle = .roundedRect
        textField.placeholder = "할 일을 입력하세요"
        
        return textField
    }()
    
    private lazy var deleteButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.setTitle("삭제하기", for: .normal)
        button.backgroundColor = .systemRed
        button.layer.cornerRadius = 5
        
        return button
    }()
    
    private lazy var updateButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.setTitle("수정하기", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 5
        
        return button
    }()
    
    private lazy var buttonStackView: UIStackView = { createStackView() }()
    
    // MARK: - Life Cycle
    
    init(data: Todo, viewModel: TodoViewModel) {
        self.data = data
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        setUI()
        setLayout()
    }
}

// MARK: - Extensions

extension TodoDetailViewController {
    private func setUI() {
        view.backgroundColor = .white
        
        [createDate, modifyDate, checkButton, titleTextField, buttonStackView].forEach {
            view.addSubview($0)
        }
    }
    
    private func setLayout() {
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: view.topAnchor),
            view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            createDate.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            createDate.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            
            modifyDate.topAnchor.constraint(equalTo: createDate.bottomAnchor, constant: 15),
            modifyDate.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            
            checkButton.topAnchor.constraint(equalTo: modifyDate.bottomAnchor, constant: 30),
            checkButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
        
            titleTextField.topAnchor.constraint(equalTo: checkButton.bottomAnchor, constant: 15),
            titleTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            titleTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            
            buttonStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            buttonStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            buttonStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func createStackView() -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [deleteButton, updateButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        
        return stackView
    }
}
