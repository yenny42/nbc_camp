//
//  PlayerTableViewCell.swift
//  Deepening_Profile
//
//  Created by t2023-m0035 on 1/29/24.
//

import UIKit

class PlayerTableViewCell: UITableViewCell {
    
    static let identifier = "PlayerTableViewCellIdentifier"
    
    // MARK: - UI Properties
    
    lazy var thumbnail: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .systemGray5
        
        return imageView
    }()
    
    lazy var title: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.numberOfLines = 0
        
        return label
    }()
    
    // MARK: - Life Cycle
    
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

extension PlayerTableViewCell {
    private func setUI() {
        [thumbnail, title].forEach {
            self.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            thumbnail.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            thumbnail.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            thumbnail.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.4),
            
            title.leadingAnchor.constraint(equalTo: self.thumbnail.trailingAnchor, constant: 20),
            title.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 15),
            title.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        ])
    }
}
