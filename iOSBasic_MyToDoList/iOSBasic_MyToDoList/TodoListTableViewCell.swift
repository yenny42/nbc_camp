//
//  ToDoListTableViewCell.swift
//  iOSBasic_MyToDoList
//
//  Created by t2023-m0035 on 12/13/23.
//

import UIKit

class ToDoListTableViewCell: UITableViewCell {
    @IBOutlet weak var todoTitleLabel: UILabel!
    @IBOutlet weak var todoCompleteButton: UIButton!
    
    var isComplete: Bool = false {
        didSet {
            if isComplete == true {
                todoCompleteButton.tintColor = UIColor.systemRed
            } else {
                todoCompleteButton.tintColor = UIColor.lightGray
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
