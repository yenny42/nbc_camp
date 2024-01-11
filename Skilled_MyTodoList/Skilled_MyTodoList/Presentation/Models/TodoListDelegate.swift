//
//  TodoListDelegate.swift
//  Skilled_MyTodoList
//
//  Created by t2023-m0035 on 1/11/24.
//

import Foundation

protocol TodoListDelegate: AnyObject {
    func didTapSwitch(isOn: Bool, indexPath: IndexPath)
}
