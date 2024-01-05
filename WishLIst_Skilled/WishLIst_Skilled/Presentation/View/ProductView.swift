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
    
    private let productImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    private let productBrand: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 0).withSize(14.0)
        label.textColor = .systemGray
        
        return label
    }()
    
    private let productName: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20).withSize(24.0)
        
        return label
    }()
    
    private let productPrice: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 0).withSize(24.0)
        label.textAlignment = .right
        
        return label
    }()
    
    private let productDiscription: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        
        return label
    }()
    
    // MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        SkeletonUI()
        setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Network Data

extension ProductView {
    func SkeletonUI() {
        productBrand.text = "-"
        productName.text = "-"
        productPrice.text = "$ 0"
        productDiscription.text = "-"
        productImage.backgroundColor = .systemGray6
    }
    
    func hideSkeletonView() {
        productBrand.text = ""
        productName.text = ""
        productPrice.text = ""
        productDiscription.text = ""
    }
    
    func updateUIWithProduct(_ product: Product) {
        productBrand.text = product.brand
        productName.text = product.title
        productPrice.text = "$ \(product.price)"
        productDiscription.text = product.description

        // if let 옵셔널 바인딩
        // - 썸네일 url이 유효한지(nil인지 아닌지) 체크
        if let thumbnailURL = URL(string: product.thumbnail) {
            // 앱 전역에서 공유되는 URLSession을 사용하여 비동기 네트워크 작업
            let task = URLSession.shared.dataTask(with: thumbnailURL) { (data, _, error) in
                if let error = error {
                    // 썸네일 url이 유효하지 않으면 출력되는 에러
                    
                    // localizedDescription
                    // - 해당 에러에 대한 사용자 친화적인 설명 문자열을 반환
                    print("Error loading thumbnail image: \(error.localizedDescription)")
                    return
                }
                else if let imageData = data, let image = UIImage(data: imageData) {
                    // 메인 스레드에서 UI 업데이트
                    DispatchQueue.main.async {
                        // 이미지가 조금 더 늦게 불러와져서 (api 요청해서 받아온 이미지 url로 다시 요청을 보내니까 아무래도 더 늦겠지..)
                        // 이미지 통신이 끝나면 스켈레톤을 hide
                        self.productImage.backgroundColor = .clear
                        self.productImage.image = image
                    }
                }
            }
            task.resume()
        }
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
        
        [createProductName(), productName].forEach {
            stackView.addArrangedSubview($0)
        }
        
        return stackView
    }
    
    private func createProductName() -> UIStackView {
        let stackView = UIStackView()
        
        stackView.axis = .horizontal
        stackView.distribution = .equalCentering
        stackView.spacing = 0
        
        [productBrand, productPrice].forEach {
            stackView.addArrangedSubview($0)
        }
        
        return stackView
    }
}
