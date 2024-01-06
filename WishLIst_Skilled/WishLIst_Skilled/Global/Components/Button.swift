//
//  Button.swift
//  WishLIst_Skilled
//
//  Created by t2023-m0035 on 1/4/24.
//

import UIKit

final class CustomButton: UIButton {

    init(title: String, color: UIColor) {
        super.init(frame: .zero)
        
        setUI(title: title, color: color)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CustomButton {
    private func setUI(title: String, color: UIColor) {
        setTitle(title, for: .normal)
        backgroundColor = color
        layer.cornerRadius = 5
    }
}
