//
//  RandomDogView.swift
//  Skilled_MyTodoList
//
//  Created by t2023-m0035 on 1/9/24.
//

import UIKit
import Gifu

class RandomDogView: UIView {
    
    // MARK: - UI Properties
    
    let gifImageView = GIFImageView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
    
    let dogImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setLoading()
        setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Extensions

extension RandomDogView {
    private func setUI() {
        self.backgroundColor = .white
        
        self.addSubview(dogImage)
        
        dogImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dogImage.topAnchor.constraint(equalTo: self.topAnchor),
            dogImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            dogImage.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            dogImage.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
    
    func setLoading() {
        
        gifImageView.animate(withGIFNamed: "loading")
        
        self.backgroundColor = .white
        
        self.addSubview(gifImageView)
        
        gifImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            gifImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            gifImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
        
        gifImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        gifImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
}
