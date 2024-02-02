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
    
    func saveData(category: String, title: String) {
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
            
            let categories = readCategory()
            if let targetCategory = categories.first(where: { $0.title == category }) {
                newTodo.category = targetCategory
            } else {
                let newCategory = Category(context: context)
                newCategory.id = UUID()
                newCategory.title = category
                newCategory.addToTasks(newTodo)
            }
            
            try context.save()
        } catch {
            print("Error saving todo: \(error)")
        }
    }
    
    func readCategory() -> [Category] {
        guard let context = self.persistentContainer?.viewContext else { return [] }
        
        let request = Category.fetchRequest()
        
        let categories = try? context.fetch(request)
        return categories!
    }
    
    func readData() -> [TaskInfo] {
        guard let context = self.persistentContainer?.viewContext else {
            print("Error fetching tasks")
            return []
        }
        
        let request = Task.fetchRequest()
        
        var data: [TaskInfo] = []
        
        let readCategoryData = readCategory()
        readCategoryData.forEach {
            let tasks = $0.tasks?.allObjects.compactMap({ $0 as? Task })
            for task in tasks! {
                let inputTask = TaskInfo(
                    id: String(describing: task.id),
                    title: task.title!,
                    createDate: task.createDate!,
                    modifyDate: task.modifyDate,
                    isCompleted: task.isCompleted,
                    category: (task.category?.title)!
                )
                
                data.append(inputTask)
            }
        }
        
        return data.sorted { $0.createDate < $1.createDate }
    }
    
    func updateData(_ id: String, title: String? = nil, isCompleted: Bool? = nil) {
        guard let context = self.persistentContainer?.viewContext else { return }
        
        let request = Task.fetchRequest()
        guard let todos = try? context.fetch(request) else { return }
        
        let filteredData = todos.first { String(describing: $0.id) == id }
        
        if title != nil {
            if title!.count > 30 {
                return
            } else {
                filteredData?.title = title
            }
        }
        
        if isCompleted != nil {
            filteredData?.isCompleted = isCompleted!
        }
        
        filteredData?.modifyDate = Date()
        
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
