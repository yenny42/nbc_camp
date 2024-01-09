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
}
