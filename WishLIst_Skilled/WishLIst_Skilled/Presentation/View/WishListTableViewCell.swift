//
//  WishListTableViewCell.swift
//  WishLIst_Skilled
//
//  Created by t2023-m0035 on 1/5/24.
//

import UIKit

class WishListTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    // MARK: - UI Properties
    
    static let identifier = "WishListCellIdentifier"
    
    let productName = UILabel()
    
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
        contentView.addSubview(productName)
        
        productName.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            productName.topAnchor.constraint(equalTo: contentView.topAnchor),
            productName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
        ])
    }
}
