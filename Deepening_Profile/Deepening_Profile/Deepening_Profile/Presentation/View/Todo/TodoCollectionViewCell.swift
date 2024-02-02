//
//  TodoCollectionViewCell.swift
//  Deepening_Profile
//
//  Created by t2023-m0035 on 1/26/24.
//

import UIKit

class TodoCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    weak var delegate: TodoCellDelegate?
    static let identifier = "TodoCollectionViewCellIdentifier"
    
    // MARK: - UI Properties
    
    lazy var title: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.numberOfLines = 0
        
        return label
    }()
    
    lazy var createDate: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .systemGray
        
        return label
    }()
    
    lazy var checkButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
        button.tintColor = .systemGray2
        
        return button
    }()
    
    lazy var categoryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .systemBlue
        
        return label
    }()
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TodoCollectionViewCell {
    private func setUI() {
        checkButton.addTarget(self, action: #selector(checkButtonTapped), for: .touchUpInside)
        
        DispatchQueue.main.async {
            self.layer.borderWidth = 1
            self.layer.borderColor = UIColor.systemGray4.cgColor
            self.layer.cornerRadius = 10
        }
        
        [checkButton, createDate, categoryLabel, title].forEach {
            self.addSubview($0)
        }
    }
    
    private func setLayout() {
        NSLayoutConstraint.activate([
            checkButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            checkButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            
            createDate.topAnchor.constraint(equalTo: self.topAnchor, constant: 12),
            createDate.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            
            categoryLabel.bottomAnchor.constraint(equalTo: self.title.topAnchor, constant: -8),
            categoryLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            
            title.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            title.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            title.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
        ])
    }
}

// MARK: TodoCellDelegate Method

extension TodoCollectionViewCell {
    @objc private func checkButtonTapped() {
        delegate?.todoCellDidTapCheckButton(self)
    }
}
