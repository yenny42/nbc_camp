//
//  WishListTableViewCell.swift
//  WishLIst_Skilled
//
//  Created by t2023-m0035 on 1/5/24.
//

import UIKit

class WishListTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    static let identifier = "WishListCellIdentifier"
    
    // MARK: - UI Properties
    
    let productName = UILabel()
    let productBrand: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .systemGray
        
        return label
    }()
    let productPrice = UILabel()
    
    // MARK: - Life Cycle
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        productName.text = ""
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}

// MARK: - Extensions

extension WishListTableViewCell {
    private func setUI() {
        [productBrand, productName, productPrice].forEach {
            contentView.addSubview($0)
        }
        
        // brand
        productBrand.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            productBrand.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            productBrand.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
        ])
        
        // name
        productName.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            productName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            productName.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15)
        ])
        
        // price
        productPrice.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            productPrice.leadingAnchor.constraint(equalTo: productName.trailingAnchor, constant: 20),
            productPrice.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15)
        ])
    }
}
