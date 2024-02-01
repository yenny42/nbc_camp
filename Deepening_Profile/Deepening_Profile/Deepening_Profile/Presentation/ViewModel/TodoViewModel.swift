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

        if title.count > 30 {
            return
        }

        do {
            let newTodo = Task(context: context)
            newTodo.id = UUID()
            newTodo.title = title
            newTodo.createDate = Date()
            newTodo.isCompleted = false

            try context.save()
        } catch {
            print("Error saving todo: \(error)")
        }
    }

    func readData() -> [TaskInfo] {
        guard let context = self.persistentContainer?.viewContext else { return [] }
        
        let request = Task.fetchRequest()
        
        do {
            let todos = try context.fetch(request)
            
            var data: [TaskInfo] = []
            
            for todo in todos {
                let todoModel = TaskInfo(
                    id: String(describing: todo.id),
                    title: todo.title!,
                    createDate: todo.createDate!,
                    modifyDate: todo.modifyDate ?? nil,
                    isCompleted: todo.isCompleted
                )
                
                data.append(todoModel)
            }
            
            return data
        } catch {
            print("Error fetching todos: \(error)")
            return []
        }
    }
    
    func updateData(_ id: String, title: String? = nil, isCompleted: Bool? = nil) {
        guard let context = self.persistentContainer?.viewContext else { return }
        
        let request = Task.fetchRequest()
        guard let todos = try? context.fetch(request) else { return }
        
        let filteredData = todos.filter { String(describing: $0.id) == id }[0]
        
        if title != nil {
            if title!.count > 30 {
                return
            } else {
                filteredData.title = title
            }
        }

        if isCompleted != nil {
            filteredData.isCompleted = isCompleted!
        }
        
        filteredData.modifyDate = Date()
        
        try? context.save()
    }
    
    func deleteData(_ id: String) {
        guard let context = self.persistentContainer?.viewContext else { return }
        
        let request = Task.fetchRequest()
        guard let todos = try? context.fetch(request) else { return }
        
        let filteredData = todos.first { String(describing: $0.id) == id }
        context.delete(filteredData!)
        
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
