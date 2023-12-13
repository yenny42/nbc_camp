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
    
    let testData: [Todo] = [Todo(title: "밥 먹기", isComplete: false), Todo(title: "양치하기", isComplete: false), Todo(title: "왜 이렇게 졸리냐 낮잠자기(안됨)", isComplete: false),Todo(title: "강아지랑 산책가기", isComplete: false)]
    
    @IBOutlet weak var ToDoListTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ToDoListTableView.dataSource = self
    }
    
    @IBAction func TappedAddTodoButton(_ sender: UIButton) {
        print("To do 를 추가해주는 버튼")
    }
    
}

extension ViewController: UITableViewDataSource {
    
    //    numberOfRowsInSection은 TableView에 표시할 행의 수를 return
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return testData.count
    }
    
    //    cellForRowAt은 Cell에 표시하기 위한 Cell을 만들어서 return
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ToDoListTableView.dequeueReusableCell(withIdentifier: "todolistCell", for: indexPath) as! TodoListTableViewCell
        cell.todoContentsLabel.text = self.testData[indexPath.row].title
        return cell
    }
    
    
}
