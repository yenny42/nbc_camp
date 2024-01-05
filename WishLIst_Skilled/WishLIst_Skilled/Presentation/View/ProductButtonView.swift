//
//  ProductButtonView.swift
//  WishLIst_Skilled
//
//  Created by t2023-m0035 on 1/4/24.
//

import UIKit

class ProductButtonView: UIView {
    
    // MARK: - Properties
    
    weak var delegate: ProductViewDelegate?
    
    // MARK: - UI Properties
    
    private let addWishListButton: CustomButton = CustomButton(title: "위시리스트 담기", color: UIColor.systemGreen)
    private let showAnotherProduct: UIButton = CustomButton(title: "다른상품 보기", color: UIColor.systemPink)
    private let showWishList: UIButton = CustomButton(title: "위시리스트 보기", color: UIColor.systemGray)
    
    // MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
        setAddTarget()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Button Action Method
    
    @objc private func tapAddWishListButton() {
        print("위시리스트 담기")
        delegate?.didTapAddWishListButton()
    }
    
    @objc private func tapShowAnotherProduct() {
        delegate?.didTapShowAnotherProduct()
    }
    
    @objc private func tapShowWishList() {
        delegate?.didTapShowWishList()
    }
}

// MARK: - Extensions

extension ProductButtonView {
    private func setAddTarget() {
        addWishListButton.addTarget(self, action: #selector(tapAddWishListButton), for: .touchUpInside)
        showAnotherProduct.addTarget(self, action: #selector(tapShowAnotherProduct), for: .touchUpInside)
        showWishList.addTarget(self, action: #selector(tapShowWishList), for: .touchUpInside)
    }
    
    private func setUI() {
        backgroundColor = .white
        
        let verticalStackView = UIStackView()
        
        verticalStackView.axis = .vertical
        verticalStackView.distribution = .fill
        verticalStackView.spacing = 15
        
        [createWishButtons(),showWishList].forEach {
            verticalStackView.addArrangedSubview($0)
        }
        
        self.addSubview(verticalStackView)
        
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            verticalStackView.topAnchor.constraint(equalTo: self.topAnchor),
            verticalStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            verticalStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            verticalStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    private func createWishButtons() -> UIStackView {
        let stackView = UIStackView()
        
        stackView.axis = .horizontal
        stackView.alignment = .bottom
        stackView.distribution = .fillEqually
        stackView.spacing = 15
        
        [addWishListButton, showAnotherProduct].forEach {
            stackView.addArrangedSubview($0)
        }
        
        return stackView
    }
}
