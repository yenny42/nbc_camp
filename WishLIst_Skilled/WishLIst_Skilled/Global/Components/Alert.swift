//
//  Alert.swift
//  WishLIst_Skilled
//
//  Created by t2023-m0035 on 1/6/24.
//

import UIKit

func actionAlert(in view: UIViewController, title: String, message: String, cancelButton: Bool = true, okHandler: @escaping () -> Void = {}) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let ok = UIAlertAction(title: "네", style: .default) {_ in
        okHandler()
    }
    let cancel = UIAlertAction(title: "아니오", style: .destructive)
    
    alert.addAction(ok)
    if cancelButton == true {
        alert.addAction(cancel)
    }
    view.present(alert, animated: true)
}
