//
//  TodoViewModel.swift
//  Deepening_Profile
//
//  Created by t2023-m0035 on 1/25/24.
//

import UIKit
import CoreData

class TodoViewModel {
    
    var persistentContainer: NSPersistentContainer? {
        (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer
    }
    
    func saveData(title: String) {
        guard let context = self.persistentContainer?.viewContext else { return }
        
        let newTodo = TodoItem(context: context)
        
        newTodo.id = UUID()
        newTodo.title = title
        newTodo.createDate = Date()
        newTodo.isCompleted = false
        
        try? context.save()
    }

    func readData() -> [Todo] {
        guard let context = self.persistentContainer?.viewContext else { return [] }
        
        let request = TodoItem.fetchRequest()
        let todos = try? context.fetch(request)
        
        var data: [Todo] = []
        
        for todo in todos! {
            let todoModel = Todo(
                id: String(describing: todo.id),
                title: todo.title!,
                createDate: todo.createDate!,
                modifyDate: todo.modifyDate ?? nil,
                isCompleted: todo.isCompleted
            )
            
            data.append(todoModel)
        }
        
        return data
    }
    
    func updateData() {
        guard let context = self.persistentContainer?.viewContext else { return }
        
        let request = TodoItem.fetchRequest()
        guard let todos = try? context.fetch(request) else { return }
        
        // update
        let filteredData = todos.filter { $0.title == "메룽메룽" }
        
        for data in filteredData {
            data.title = "water melon"
        }
        
        try? context.save()
    }
    
    func deleteData() {
        guard let context = self.persistentContainer?.viewContext else { return }
        
        let request = TodoItem.fetchRequest()
        guard let todos = try? context.fetch(request) else { return }
        
        let filteredData = todos.filter { $0.title == "water melon" }
        
        for data in filteredData {
            context.delete(data)
        }
        
        try? context.save()
    }
    
}

extension TodoViewModel {
    func dateFormat(_ input: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        
        let currentDate = input
        let formattedDate = dateFormatter.string(from: currentDate)
        
        return formattedDate
    }
}
