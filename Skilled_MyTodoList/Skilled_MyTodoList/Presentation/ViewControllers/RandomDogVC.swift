
//  RandomDogVC.swift
//  Skilled_MyTodoList
//
//  Created by t2023-m0035 on 1/9/24.
//

import UIKit

class RandomDogVC: UIViewController {
    
    // MARK: - UI Properties
    
    let randomDogView = RandomDogView()

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchRandomDog()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.randomDogView.gifImageView.startAnimatingGIF()
        self.randomDogView.dogImage.image = nil
    }
}

// MARK: - Extensions

extension RandomDogVC {
    private func setUI() {
        view.backgroundColor = .white
        view.addSubview(randomDogView)
        
        randomDogView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            randomDogView.topAnchor.constraint(equalTo: view.topAnchor),
            randomDogView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            randomDogView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            randomDogView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension RandomDogVC {
    
    func fetchRandomDog() {
        RandomDogRequest.decodeRandomDog { result in
            DispatchQueue.main.async {
                switch result {
                    case .success(let randomDog):
                        let data = randomDog.dog.first
                        self.setDogImage(data!.url)
                    case .failure(let error):
                        print("Error decoding RandomDog: \(error)")
                }
            }
        }
    }
    
    private func setDogImage(_ url: String) {
        ImageLoader.loadImage(from: url, into: self.randomDogView.dogImage) {
            self.randomDogView.gifImageView.stopAnimatingGIF()
        }
    }
}

