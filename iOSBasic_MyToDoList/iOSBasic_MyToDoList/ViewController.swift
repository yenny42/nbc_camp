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
}

class ViewController: UIViewController {
    
    @IBOutlet weak var TodoListTableView: UITableView!
    
    var testData: [Todo] = [Todo(title: "밥 먹기", isComplete: false), Todo(title: "양치하기", isComplete: false), Todo(title: "왜 이렇게 졸리냐 낮잠자기(안됨)", isComplete: false),Todo(title: "강아지랑 산책가기", isComplete: false)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        TodoListTableView.dataSource = self
    }
    
    @IBAction func AddTodoContents(_ sender: UIButton) {
        let alert = UIAlertController(title: "Add Todo", message: "추가할 내용을 입력해주세요.", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
            let inputTitle = String((alert.textFields?[0].text)!)
            
            self.testData.append(Todo(title: inputTitle, isComplete: false))
            self.TodoListTableView.reloadData()
        }))
        alert.addAction(UIAlertAction(title: NSLocalizedString("CANCEL", comment: "Default action"), style: .default, handler: { _ in
            NSLog("The \"Cancel\" alert occured.")
        }))
        alert.addTextField(configurationHandler: {
            textField in
            textField.placeholder = "To do Contents"
        })
        
        self.present(alert, animated: true, completion: nil)
    }
    
}

extension ViewController: UITableViewDataSource {
    
    // MARK: Cell 추가
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //    numberOfRowsInSection은 TableView에 표시할 행의 수를 return
        return testData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //    cellForRowAt은 Cell에 표시하기 위한 Cell을 만들어서 return
        let cell = TodoListTableView.dequeueReusableCell(withIdentifier: "TodoListCell", for: indexPath) as! ToDoListTableViewCell
        cell.selectionStyle = .none
        cell.todoTitleLabel.text = self.testData[indexPath.row].title
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
            TodoListTableView.deleteRows(at: [indexPath], with: .fade)
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


