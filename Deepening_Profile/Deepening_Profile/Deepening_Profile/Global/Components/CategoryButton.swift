//
//  CategoryButton.swift
//  Deepening_Profile
//
//  Created by t2023-m0035 on 2/2/24.
//

import UIKit

func createCategoryButton(title: String, color: UIColor) -> UIButton {
    let button = UIButton(type: .system)
    button.setTitle(title, for: .normal)
    button.tintColor = color
    button.layer.borderWidth = 1
    button.layer.borderColor = color.cgColor
    button.layer.cornerRadius = 13
    button.contentEdgeInsets = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
    
    return button
}
