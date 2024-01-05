//
//  ViewController.swift
//  WishLIst_Skilled
//
//  Created by t2023-m0035 on 1/4/24.
//

import UIKit

class ProductVC: UIViewController {
    
    // MARK: - Properties
    
    // MARK: - UI Properties
    
    private lazy var stackView: UIStackView = { createStackView() }()
    
    private let wishListVC = WishListVC()
    private let productView = ProductView()
    private let productButtonView = ProductButtonView()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDelegate()
        setUI()
        setLayout()
    }
    
}

extension ProductVC: ProductViewDelegate {
    func didTapShowWishList() {
        self.present(wishListVC, animated: true)
    }
}

// MARK: - Extensions

extension ProductVC {
    private func setUI() {
        view.backgroundColor = .white
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        productView.translatesAutoresizingMaskIntoConstraints = false
        productButtonView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setLayout() {
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40)
        ])
        
        productView.heightAnchor.constraint(equalTo: stackView.heightAnchor, multiplier: 0.75).isActive = true
        productButtonView.heightAnchor.constraint(equalTo: stackView.heightAnchor, multiplier: 0.25).isActive = true
    }
    
    private func setDelegate() {
        productButtonView.delegate = self
    }
    
    private func createStackView() -> UIStackView {
        let stackView = UIStackView()
        
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        
        [productView, productButtonView].forEach { stackView.addArrangedSubview($0) }
        
        return stackView
    }
}
