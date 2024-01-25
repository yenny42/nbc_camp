//
//  TodoViewModel.swift
//  Deepening_Profile
//
//  Created by t2023-m0035 on 1/25/24.
//

import Foundation

class TodoViewModel {
    func dateFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        
        let currentDate = Date()
        let formattedDate = dateFormatter.string(from: currentDate)
        
        return formattedDate
    }
}
