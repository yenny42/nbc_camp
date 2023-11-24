//
//  ViewController.swift
//  PracticeUI
//
//  Created by t2023-m0035 on 11/24/23.
//

import UIKit

struct Family {
    let myName: String
    let bestFriendName: String
    let nextFriendName: String
    let myBrother: String
}

class ViewController: UIViewController {
    
    // MARK: - Names IBOutlet
    @IBOutlet weak var nameLable: UILabel!
    @IBOutlet weak var krNameLabel: UILabel!
    @IBOutlet weak var myNameLabel: UILabel!
    @IBOutlet weak var bestFriendLabel: UILabel!
    @IBOutlet weak var nextFriendLabel: UILabel!
    
    // MARK: Names 변수
    let frinedEnNames: [String] = ["John","Henry","Leeo"]
    let friendKrNames: [String:String] = ["John":"존","Henry":"헨리","Leeo":"리오"]
    var count: Int = 0
    
    let freind = Family(myName: "John2", bestFriendName: "Henry2", nextFriendName: "Leeo2", myBrother: "Key")
    
    // MARK: - viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Names IBAction
    @IBAction func didTapButton(_ sender: Any) {
        let nameValue = frinedEnNames[count]
        nameLable.text = nameValue
        krNameLabel.text = friendKrNames[nameValue]
        count += 1
    }
    
    @IBAction func didTapIntroduceButton(_ sender: UIButton) {
//        myNameLabel.text = frinedEnNames[0]
//        bestFriendLabel.text = frinedEnNames[1]
//        nextFriendLabel.text = frinedEnNames[2]
        
        myNameLabel.text = freind.myName
        bestFriendLabel.text = freind.bestFriendName
        nextFriendLabel.text = freind.nextFriendName
        // myBrother
    }
}

