//
//  AddTodoVC.swift
//  iOSBasic_MyToDoList
//
//  Created by t2023-m0035 on 12/20/23.
//

import UIKit

class AddTodoVC: UIViewController {
    @IBOutlet weak var todoTextField: UITextField!
    @IBOutlet weak var warningTitleLabel: UILabel!
    @IBOutlet weak var todayLabel: UILabel!
    @IBOutlet weak var dueDatePicker: UIDatePicker!
    
    weak var delegate: TodoAddDelegate?
    
    var inputData: Todo = Todo(title: "", isComplete: false, regDate: "", dueDate: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        todayLabel.text = Date().toString("yy.M.d")
    }
    
    @IBAction func AddTodoButton(_ sender: UIButton) {
        let compareDate = (dueDatePicker.date.toString("yyMMdd")).compare(Date().toString("yyMMdd"))
        if  compareDate != .orderedAscending {
            inputData = Todo(title: todoTextField.text!, isComplete: false, regDate: todayLabel.text!, dueDate: dueDatePicker.date.toString("yy.M.d"))
            
            if self.inputData.title == "" {
                warningText()
            } else {
                delegate?.sendData(data: inputData)
                navigationController?.popViewController(animated: true)
            }
        } else {
            warningDatePicker()
        }
    }
    
    func warningText() {
        warningTitleLabel.textColor = .systemRed
    }
    
    func warningDatePicker() {
        let alert = UIAlertController(title: "날짜를 다시 골라주세요.", message: "오늘 이전의 날짜는 마감일로 설정할 수 없습니다.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default))
        self.present(alert, animated: true, completion: nil)
    }
}
