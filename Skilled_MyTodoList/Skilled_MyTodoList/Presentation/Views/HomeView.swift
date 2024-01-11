//
//  HomeView.swift
//  Skilled_MyTodoList
//
//  Created by t2023-m0035 on 1/9/24.
//

import UIKit
import Gifu

final class HomeView: UIView {
    
    // MARK: - Properties
    
    let gifImageView = GIFImageView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
    
    // MARK: - UI Properties
    
    let mainImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    let showTodoListButton: UIButton = {
        let button = UIButton()
        button.setTitle("🖊 할 일 목록보기", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        
        return button
    }()
    
    let showCompletedListButton: UIButton = {
        let button = UIButton()
        button.setTitle("✅ 완료한 일 보기", for: .normal)
        button.setTitleColor(.systemGreen, for: .normal)
        
        return button
    }()
    
    let showDogImage: UIButton = {
        let button = UIButton()
        button.setTitle("🐾 힘내라멍", for: .normal)
        button.setTitleColor(.brown, for: .normal)
        
        return button
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

extension HomeView {
    private func setUI() {
        let stackView = UIStackView()
        
        stackView.axis = .vertical
        stackView.distribution = .fill
        
        [mainImage, showTodoListButton, showCompletedListButton, showDogImage].forEach { stackView.addArrangedSubview($0) }
        
        self.addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 60),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -150)
        ])
        
        mainImage.heightAnchor.constraint(equalTo: stackView.heightAnchor, multiplier: 0.7).isActive = true
        showTodoListButton.heightAnchor.constraint(equalTo: stackView.heightAnchor, multiplier: 0.1).isActive = true
        showCompletedListButton.heightAnchor.constraint(equalTo: stackView.heightAnchor, multiplier: 0.1).isActive = true
        showDogImage.heightAnchor.constraint(equalTo: stackView.heightAnchor, multiplier: 0.1).isActive = true
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
