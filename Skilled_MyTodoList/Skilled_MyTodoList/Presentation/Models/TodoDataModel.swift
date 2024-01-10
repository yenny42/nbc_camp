//
//  TodoDataModel.swift
//  Skilled_MyTodoList
//
//  Created by t2023-m0035 on 1/9/24.
//

import Foundation

struct TodoData: Codable {
    var category: String
    var title: String
    var isCompleted: Bool
    
    
    // MARK: - CRUD Methods
    
    static func saveTodoData(_ data: TodoData) {
        let encoder = JSONEncoder()

        if let encoded = try? encoder.encode(data) {
            UserDefaults.standard.set(encoded, forKey: String(describing: UUID()))
        }
    }
    
    static func loadTodoData() -> [TodoData] {
        if let savedData = UserDefaults.standard.data(forKey: "todos"),
           let todos = try? JSONDecoder().decode([TodoData].self, from: savedData) {
            return todos
        } else {
            return []
        }
    }
    
    static func loadAllData() -> [(TodoData, key: String)] {
        let allUserDefaults = UserDefaults.standard.dictionaryRepresentation()
        var value: [(TodoData, key: String)] = []
        
        for (key, _) in allUserDefaults {
            if let savedData = UserDefaults.standard.object(forKey: key) as? Data {
                let decoder = JSONDecoder()
                if let savedObject = try? decoder.decode(TodoData.self, from: savedData) {
                    value.append((savedObject, key))
                }
            }
        }
        
        return value
    }
    
    static func updateTodoData(value: TodoData, forKey key: String) {
        let encoder = JSONEncoder()

        if let encoded = try? encoder.encode(value) {
            UserDefaults.standard.set(encoded, forKey: key)
        }
    }
    
    static func removeUserDefaults(forKey key: String) {
        UserDefaults.standard.removeObject(forKey: key)
    }
}
