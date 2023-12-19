//
//  ViewController.swift
//  iOSBasic_MyToDoList
//
//  Created by t2023-m0035 on 12/13/23.
//

import UIKit

struct Todo {
    var title: String
    var isComplete: Bool
    var regDate: String
}

class ViewController: UIViewController {
    
    @IBOutlet weak var TodoListTableView: UITableView!
    
    var testData: [Todo] = [Todo(title: "test title", isComplete: false, regDate: "23.12.17")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        TodoListTableView.dataSource = self
        TodoListTableView.delegate = self
    }
    
    @IBAction func AddTodoContents(_ sender: UIButton) {
        let alert = UIAlertController(title: "Add Todo", message: "추가할 내용을 입력해주세요.", preferredStyle: .alert)
        
        alert.addTextField(configurationHandler: {
            textField in
            textField.placeholder = "To do Contents"
        })
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .destructive, handler: { _ in
            let inputTitle = String((alert.textFields?[0].text)!)
            if let inputTitle = alert.textFields?[0].text {
                self.testData.append(Todo(title: inputTitle, isComplete: false, regDate: Date().toString("yy.M.d")))
                
                self.TodoListTableView.beginUpdates()
                self.TodoListTableView.insertRows(at: [IndexPath(row: self.testData.count-1, section: 0)], with: .automatic)
                self.TodoListTableView.endUpdates()
            }
        }))
        alert.addAction(UIAlertAction(title: NSLocalizedString("CANCEL", comment: "Default action"), style: .default))
        
        self.present(alert, animated: true, completion: nil)
    }
    
}

// MARK: UITableViewDataSource
extension ViewController: UITableViewDataSource {
    
    // MARK: Cell 생성
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return testData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TodoListTableView.dequeueReusableCell(withIdentifier: "TodoListCell", for: indexPath) as! ToDoListTableViewCell
        
        cell.selectionStyle = .none
        cell.todoTitleLabel.text = self.testData[indexPath.row].title
        cell.todoDateLabel.text = self.testData[indexPath.row].regDate
        cell.todoCompleteButton.tag = indexPath.row
        
        cell.todoCompleteButton.addTarget(self, action: #selector(checkBoxButtonTapped(sender:)), for: .touchUpInside)
        
        return cell
    }
    
    // MARK: Delete Table View Cell
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.testData.remove(at: indexPath.row)
            
            TodoListTableView.beginUpdates()
            TodoListTableView.deleteRows(at: [indexPath], with: .fade)
            TodoListTableView.endUpdates()
        }
    }
    
    // MARK: Complete Check
    @objc func checkBoxButtonTapped(sender: UIButton) {
        guard let cell = sender.superview?.superview as? ToDoListTableViewCell else {
            return
        }
        
        let index = sender.tag
        
        !testData[index].isComplete ? (testData[index].isComplete = true) : (testData[index].isComplete = false)
        cell.isComplete = testData[index].isComplete
    }
}

// MARK: UITableViewDelegate
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0
    }
}
