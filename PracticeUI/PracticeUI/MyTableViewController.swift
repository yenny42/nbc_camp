//
//  MyTableViewController.swift
//  PracticeUI
//
//  Created by t2023-m0035 on 11/24/23.
//

import UIKit

class MyTableViewController: UIViewController {
    
    @IBOutlet weak var myTableView: UITableView!
    
    let frinedEnNames: [String] = ["John","Henry","Leeo","Key","Yenny"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // delegate - 위임
        // selft == MyTableViewController
        myTableView.delegate = self
        myTableView.dataSource = self
    }
}

extension MyTableViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return frinedEnNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTableView.dequeueReusableCell(withIdentifier: "myFirstCell", for: indexPath)
        
        // indexPath -> 테이블 뷰의 순서를 담고 있는 매개변수
        cell.textLabel?.text = frinedEnNames[indexPath.row]
        
        return cell
    }
    
}
