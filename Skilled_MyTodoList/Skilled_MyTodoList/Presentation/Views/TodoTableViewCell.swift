//
//  TodoTableViewCell.swift
//  Skilled_MyTodoList
//
//  Created by t2023-m0035 on 1/10/24.
//

import UIKit

final class TodoTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    static let identifier = "TodoCellIdentifier"
    
    weak var delegate: TodoListDelegate?
    var indexPath: IndexPath?
    
    // MARK: - UI Properties
    
    let isCompleted = UISwitch()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: Delegate Method
    
    @objc private func tapSwitch() {
        if let indexPath = indexPath {
            delegate?.didTapSwitch(isOn: isCompleted.isOn, indexPath: indexPath)
        }
    }
}

extension TodoTableViewCell {
    private func setUI() {
        isCompleted.addTarget(self, action: #selector(tapSwitch), for: .valueChanged)
        
        contentView.addSubview(isCompleted)
        
        isCompleted.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            isCompleted.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            isCompleted.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
}
