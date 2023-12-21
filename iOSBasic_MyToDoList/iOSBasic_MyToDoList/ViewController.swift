//
//  ViewController.swift
//  iOSBasic_MyToDoList
//
//  Created by t2023-m0035 on 12/13/23.
//
// TODO: 휴지통, 글 수정

import UIKit

class ViewController: UIViewController, TodoAddDelegate {
    @IBOutlet weak var TodoListTableView: UITableView!
    
    var testData: [Todo] = [Todo(title: "test title", isComplete: false, regDate: "23.12.17", dueDate: "23.12.18"),
                            Todo(title: "test title", isComplete: false, regDate: "23.12.17", dueDate: "23.12.18")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        TodoListTableView.dataSource = self
        TodoListTableView.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let addTodoVC = segue.destination as? AddTodoVC {
            addTodoVC.delegate = self
        }
    }
    
    func sendData(data: Todo) {
        testData.append(data)
        
        TodoListTableView.beginUpdates()
        TodoListTableView.insertRows(at: [IndexPath(row: self.testData.count - 1, section: 0)], with: .automatic)
        TodoListTableView.endUpdates()
    }
    
    @IBAction func TappedAllClearButton(_ sender: Any) {
        allClearButtonAlert()
    }
    
    func allClearButtonAlert() {
        let alert = UIAlertController(title: "전부 삭제하시겠습니까?", message: "복구가 불가능합니다.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .destructive, handler: { _ in
            self.testData.removeAll()
            self.TodoListTableView.reloadData()
        }))
        alert.addAction(UIAlertAction(title: NSLocalizedString("취소", comment: ""), style: .default))
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
        cell.todoDateLabel.text = "등록일: \(self.testData[indexPath.row].regDate)"
        cell.todoDueDateLabel.text = "마감일: \(self.testData[indexPath.row].dueDate)"
        cell.todoCompleteButton.tag = indexPath.row
        
        cell.todoCompleteButton.addTarget(self, action: #selector(checkBoxButtonTapped(sender:)), for: .touchUpInside)
        
        return cell
    }
    
    // MARK: Delete Table View Cell
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // MARK: Click delete of Swipe delete
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
        
        testData[index].isComplete.toggle()
        cell.isComplete = testData[index].isComplete
    }
}

// MARK: UITableViewDelegate
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0
    }
}
