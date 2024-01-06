//
//  WishListVC.swift
//  WishLIst_Skilled
//
//  Created by t2023-m0035 on 1/4/24.
//

import UIKit

protocol WishListViewDelegate: AnyObject {
    func getWishListData(_ data: [WishList])
}

class WishListVC: UIViewController {
    
    // MARK: - Properties
    
    var wishList: [WishList] = []
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
    }
}

// MARK: - Delegate

extension WishListVC: WishListViewDelegate {
    func getWishListData(_ data: [WishList]) {
        print(data)
        wishList = data
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
        wishListTable.rowHeight = 70.0
        
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
        return wishList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WishListTableViewCell.identifier, for: indexPath) as! WishListTableViewCell
        cell.selectionStyle = .none
        
        cell.productBrand.text = wishList[indexPath.row].brand
        cell.productName.text = wishList[indexPath.row].name
        cell.productPrice.text = "$ \(wishList[indexPath.row].price)"
        
        return cell
    }
}
