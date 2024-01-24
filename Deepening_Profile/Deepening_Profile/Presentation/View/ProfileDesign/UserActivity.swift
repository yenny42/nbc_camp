//
//  UserActivity.swift
//  Deepening_Profile
//
//  Created by t2023-m0035 on 1/24/24.
//

import UIKit

class UserActivityView: UIView {
    private let countLabel: UILabel = UILabel()
    private let titleLabel: UILabel = UILabel()
    
    init(count: Int, title: String) {
        super.init(frame: .zero)
        setUI()
        updateView(count: count, title: title)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        let stackView = UIStackView(arrangedSubviews: [countLabel, titleLabel])
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    func updateView(count: Int, title: String) {
        countLabel.text = String(describing: count)
        titleLabel.text = title
    }
}
