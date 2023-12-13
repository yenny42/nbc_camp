//
//  TodoListTableViewCell.swift
//  iOSBasic_MyToDoList
//
//  Created by t2023-m0035 on 12/13/23.
//

import UIKit

class TodoListTableViewCell: UITableViewCell {

    @IBOutlet weak var todoContentsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func TodoCompleteButton(_ sender: UIButton) {
        print("true(했음!) 상태면 하트를 채워줘용")
    }
    
    @IBAction func TodoDeleteButton(_ sender: Any) {
        print("X 를 누르면 To do 를 삭제해용")
    }
    
}
