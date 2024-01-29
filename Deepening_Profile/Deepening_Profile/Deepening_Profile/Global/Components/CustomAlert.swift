//
//  CustomAlert.swift
//  Deepening_Profile
//
//  Created by t2023-m0035 on 1/27/24.
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

func maxinumStringAlert(in view: UIViewController) {
    let alert = UIAlertController(title: "글자 수 제한", message: "30자 이내로 입력해주세요.", preferredStyle: .alert)
    
    let ok = UIAlertAction(title: "OK", style: .default)
    alert.addAction(ok)
    
    view.present(alert, animated: true)
}
