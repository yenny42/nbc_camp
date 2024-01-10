//
//  HomeVC.swift
//  Skilled_MyTodoList
//
//  Created by t2023-m0035 on 1/9/24.
//

import UIKit

class HomeVC: UIViewController {
    
    var dataList: [TodoData] = []
    
    // MARK: - UI Properties
    
    let homeView = HomeView()
    let todoListVC = TodoListVC()
    let todoTableViewCell = TodoTableViewCell()
    let completedListVC = CompletedListVC()
    let randomDogVC = RandomDogVC()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        removeAllUserDefaults()
        setUI()
    }
}

// MARK: - UIButton Action Methods

extension HomeVC {
    @objc private func didTapShowTodoButton() {
        self.navigationController?.pushViewController(todoListVC, animated: true)
    }
    
    @objc private func didTapShowCompletedButton() {
        self.navigationController?.pushViewController(completedListVC, animated: true)
    }
    
    @objc private func didTapShowRandomDogImageButton() {
        self.present(randomDogVC, animated: true)
    }
}

// MARK: - UserDefaults CRUD

extension HomeVC {
    

    
    func updateTodoData(value: TodoData, forKey key: String) {
        // 기존 TodoData 불러오기
        if let savedData = UserDefaults.standard.object(forKey: key) as? Data {
            let decoder = JSONDecoder()
            if var existingTodoData = try? decoder.decode(TodoData.self, from: savedData) {
                // 기존 TodoData 수정
                existingTodoData.category = value.category
                existingTodoData.title = value.title
                existingTodoData.isCompleted = value.isCompleted

                // 수정된 TodoData 저장
                let encoder = JSONEncoder()
                if let updatedData = try? encoder.encode(existingTodoData) {
                    UserDefaults.standard.set(updatedData, forKey: key)
                }
            }
        }
    }
    
    func removeAllUserDefaults() {
        if let appDomain = Bundle.main.bundleIdentifier {
            UserDefaults.standard.removePersistentDomain(forName: appDomain)
        }
    }
    
    func removeUserDefaults(forKey key: String) {
        UserDefaults.standard.removeObject(forKey: key)
    }
}

// MARK: - Extensions

extension HomeVC {
    private func setAddTarget() {
        homeView.goButton.addTarget(self, action: #selector(didTapShowTodoButton), for: .touchUpInside)
        homeView.showCompletedListButton.addTarget(self, action: #selector(didTapShowCompletedButton), for: .touchUpInside)
        homeView.showDogImage.addTarget(self, action: #selector(didTapShowRandomDogImageButton), for: .touchUpInside)
    }
    
    private func setUI() {
        setAddTarget()
        setMainImage()
        
        view.backgroundColor = .white
        view.addSubview(homeView)
        
        homeView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            homeView.topAnchor.constraint(equalTo: view.topAnchor),
            homeView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            homeView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            homeView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setMainImage() {
        ImageLoader.loadImage(from: "https://spartacodingclub.kr/css/images/scc-og.jpg", into: self.homeView.mainImage)
    }
}
