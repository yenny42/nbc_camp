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
    
    let productImage: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .black
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    let productBrand: UILabel = {
        let label = UILabel()
        label.text = "brand"
        label.font = UIFont.boldSystemFont(ofSize: 0).withSize(14.0)
        label.textColor = .systemGray
        
        return label
    }()
    
    let productName: UILabel = {
        let label = UILabel()
        label.text = "name"
        label.font = UIFont.boldSystemFont(ofSize: 20).withSize(24.0)
        
        return label
    }()
    
    let productPrice: UILabel = {
        let label = UILabel()
        label.text = "price"
        label.font = UIFont.boldSystemFont(ofSize: 0).withSize(24.0)
        label.textAlignment = .right
        
        return label
    }()
    
    let productDiscription: UILabel = {
        let label = UILabel()
        label.text = "Discription Discription Discription Discription Discription Discription Discription Discription Discription "
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        
        return label
    }()
    
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
        backgroundColor = .white
        
        let verticalStackView = UIStackView()
        
        verticalStackView.axis = .vertical
        verticalStackView.distribution = .fill
        verticalStackView.spacing = 20
        
        [productImage, createProductInfo(), productDiscription].forEach {
            verticalStackView.addArrangedSubview($0)
        }
        
        self.addSubview(verticalStackView)
        
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            verticalStackView.topAnchor.constraint(equalTo: self.topAnchor),
            verticalStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            verticalStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            verticalStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
    
    private func createProductInfo() -> UIStackView {
        let stackView = UIStackView()
        
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 15
        
        [productBrand, createProductName()].forEach {
            stackView.addArrangedSubview($0)
        }
        
        return stackView
    }
    
    private func createProductName() -> UIStackView {
        let stackView = UIStackView()
        
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 0
        
        [productName, productPrice].forEach {
            stackView.addArrangedSubview($0)
        }
        
        return stackView
    }
}
