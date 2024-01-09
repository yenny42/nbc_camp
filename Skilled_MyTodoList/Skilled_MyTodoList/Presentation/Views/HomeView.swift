//
//  HomeView.swift
//  Skilled_MyTodoList
//
//  Created by t2023-m0035 on 1/9/24.
//

import UIKit

class HomeView: UIView {
    
    let mainImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .systemGray
        
        return imageView
    }()
    
    let goButton: UIButton = {
        let button = UIButton()
        button.setTitle("할 일 목록보기", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        
        return button
    }()
    
    let showButton: UIButton = {
        let button = UIButton()
        button.setTitle("완료한 일 보기", for: .normal)
        button.setTitleColor(.systemPink, for: .normal)
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension HomeView {
    
    private func setUI() {
        setMainImage()
        
        let stackView = UIStackView()
        
        stackView.axis = .vertical
        stackView.distribution = .fill
        
        [mainImage, goButton, showButton].forEach { stackView.addArrangedSubview($0) }
        
        self.addSubview(stackView)
        
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 100),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -60)
        ])
        
        mainImage.heightAnchor.constraint(equalTo: stackView.heightAnchor, multiplier: 0.6).isActive = true
        goButton.heightAnchor.constraint(equalTo: stackView.heightAnchor, multiplier: 0.2).isActive = true
        showButton.heightAnchor.constraint(equalTo: stackView.heightAnchor, multiplier: 0.2).isActive = true
    }
    
    private func setMainImage() {
        if let imageURL = URL(string: "https://spartacodingclub.kr/css/images/scc-og.jpg") {
            let task = URLSession.shared.dataTask(with: imageURL) { (data, _, error) in
                if let error = error {
                    print("Error loading thumbnail image: \(error.localizedDescription)")
                    return
                }
                else if let imageData = data, let image = UIImage(data: imageData) {
                    DispatchQueue.main.async {
                        self.mainImage.backgroundColor = .clear
                        self.mainImage.image = image
                    }
                }
            }
            task.resume()
        }
    }
}
