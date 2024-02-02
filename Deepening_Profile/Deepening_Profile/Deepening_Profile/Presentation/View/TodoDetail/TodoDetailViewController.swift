//
//  TodoDetailViewController.swift
//  Deepening_Profile
//
//  Created by t2023-m0035 on 1/26/24.
//

import UIKit

class TodoDetailViewController: UIViewController {
    
    // MARK: - Properties
    
    private var data: TaskInfo
    private var viewModel: TodoViewModel
    private var categoryData: String = ""
    
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
        
        if data.isCompleted {
            button.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
            button.tintColor = .systemGreen
        } else {
            button.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
            button.tintColor = .systemGray2
        }
        
        button.addTarget(self, action: #selector(didTapUpdateIsCompletedButton), for: .touchUpInside)
            
        return button
    }()
    
    private lazy var titleTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        
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
        
        button.addTarget(self, action: #selector(didTapDeleteButton), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var updateButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.setTitle("수정하기", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 5
        
        button.addTarget(self, action: #selector(didTapUpdateTaskButton), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var buttonStackView: UIStackView = { createActionButtonStackView() }()
    
    private lazy var studyButton = createCategoryButton(title: "공부", color: .systemBlue)
    private lazy var houseWorkButton = createCategoryButton(title: "집안일", color: .systemPink)
    private lazy var exerciseButton = createCategoryButton(title: "운동", color: .systemGreen)

    private lazy var categoryStackView: UIStackView = { createCategoryButtonStackView() }()
    
    // MARK: - Life Cycle
    
    init(data: TaskInfo, viewModel: TodoViewModel) {
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
        setAddTarget()
    }
}

// MARK: - Extensions

extension TodoDetailViewController {
    private func setAddTarget() {
        studyButton.addTarget(self, action: #selector(categoryButtonTapped), for: .touchUpInside)
        houseWorkButton.addTarget(self, action: #selector(categoryButtonTapped), for: .touchUpInside)
        exerciseButton.addTarget(self, action: #selector(categoryButtonTapped), for: .touchUpInside)
    }
    
    private func setUI() {
        view.backgroundColor = .white
        self.title = "Detail"
        
        isSelectCategoryUI()
        
        [createDate, modifyDate, checkButton, titleTextField, buttonStackView, categoryStackView].forEach {
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
            
            categoryStackView.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 15),
            categoryStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            
            buttonStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            buttonStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            buttonStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -15)
        ])
    }
    
    private func createActionButtonStackView() -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [deleteButton, updateButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        
        return stackView
    }
    
    private func createCategoryButtonStackView() -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [studyButton, houseWorkButton, exerciseButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .leading
        
        return stackView
    }
}

// MARK: - @objc Method

extension TodoDetailViewController {
    @objc
    private func didTapDeleteButton() {
        actionAlert(in: self, title: "삭제하기", message: "삭제하시겠습니까?") {
            self.viewModel.deleteData(self.data.id)
            self.navigationController?.popViewController(animated: true)
            
            actionAlert(in: self, title: "삭제가 완료되었습니다.", message: "", cancelButton: false)
        }
    }
    
    @objc
    private func didTapUpdateTaskButton() {
        let id = data.id
        
        if titleTextField.text!.count > 30 {
            maxinumStringAlert(in: self)
        } else {
            viewModel.updateData(data.id, title: titleTextField.text, category: categoryData)
        }
        
        if let index = viewModel.readData().firstIndex(where: { $0.id == id }) {
            data = viewModel.readData()[index]
        }
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc
    private func didTapUpdateIsCompletedButton() {
        let id = data.id
        viewModel.updateData(data.id, isCompleted: !data.isCompleted)
        
        if let index = viewModel.readData().firstIndex(where: { $0.id == id }) {
            data = viewModel.readData()[index]
        }
        
        DispatchQueue.main.async {
            self.updateCheckButtonUI()
        }
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
        
        self.categoryData = (sender.titleLabel?.text)!
    }
}

extension TodoDetailViewController {
    private func updateCheckButtonUI() {
        if data.isCompleted {
            checkButton.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
            checkButton.tintColor = .systemGreen
        } else {
            checkButton.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
            checkButton.tintColor = .systemGray2
        }
    }
    
    private func isSelectCategoryUI() {
        for button in [studyButton, houseWorkButton, exerciseButton] {
            if button.titleLabel?.text == data.category {
                button.backgroundColor = UIColor(cgColor: button.layer.borderColor!)
                button.setTitleColor(.white, for: .normal)
                
                self.categoryData = (button.titleLabel?.text)!
            }
        }
    }
}
