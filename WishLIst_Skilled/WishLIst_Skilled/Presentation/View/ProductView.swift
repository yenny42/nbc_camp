//
//  ProductView.swift
//  WishLIst_Skilled
//
//  Created by t2023-m0035 on 1/4/24.
//

import UIKit

class ProductView: UIView {
    
    // MARK: - Properties
    // MARK: - UI Properties
    
    // MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // 초기화 코드
        setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - Extensions

extension ProductView {
    private func setUI() {
        backgroundColor = .systemBlue
//        heightAnchor.constraint(equalToConstant: 0.6).isActive = true
    }
}
