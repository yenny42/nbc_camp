//
//  WishListVC.swift
//  WishLIst_Skilled
//
//  Created by t2023-m0035 on 1/4/24.
//

import UIKit

class WishListVC: UIViewController {
    
    // MARK: - Properties
    
    let data = ["항목 1", "항목 2", "항목 3", "항목 4", "항목 5"]
    
    // MARK: - UI Properties
    
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        setDelegate()
        setUI()
    }
    
}

// MARK: - Extensions

extension WishListVC {
    private func setUI() {
        view.backgroundColor = .white
        
        let wishListTable = UITableView()
        
        wishListTable.dataSource = self
        wishListTable.delegate = self
        
        wishListTable.backgroundColor = .white
        wishListTable.register(WishListTableViewCell.self, forCellReuseIdentifier: WishListTableViewCell.identifier)
        
        view.addSubview(wishListTable)
        
        wishListTable.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            wishListTable.topAnchor.constraint(equalTo: view.topAnchor),
            wishListTable.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            wishListTable.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            wishListTable.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
    }
}

extension WishListVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WishListTableViewCell.identifier, for: indexPath) as! WishListTableViewCell
        
        cell.productName.text = data[indexPath.row]
        
        return cell
    }
}
