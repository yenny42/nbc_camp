//
//  ViewController.swift
//  MyAction
//
//  Created by t2023-m0035 on 11/24/23.
//

import UIKit

class ViewController: UIViewController {
    // MARK: IBOutlet
    @IBOutlet weak var helloLable: UILabel!
    @IBOutlet weak var myButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    //MARK: IBAction
    @IBAction func didTapMyButton(_ sender: Any) {
//        print("눌렀다가 뗄 때 동작해용")
//        view.backgroundColor = .yellow
        
        helloLable.text = "hello, my name is yenny"
    }
    

}

