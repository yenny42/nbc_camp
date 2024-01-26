//
//  TodoDetailViewController.swift
//  Deepening_Profile
//
//  Created by t2023-m0035 on 1/26/24.
//

import UIKit

class TodoDetailViewController: UIViewController {
    
    let data: Todo?
    
    init(data: Todo) {
        self.data = data
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemPink
        print("디테일~ \(data)")
    }
    
}
