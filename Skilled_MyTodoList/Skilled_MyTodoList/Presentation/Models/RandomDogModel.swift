//
//  RandomDogModel.swift
//  Skilled_MyTodoList
//
//  Created by t2023-m0035 on 1/9/24.
//

import Foundation

struct RandomDog: Decodable {
    let dog: [Dog]
}

struct Dog: Decodable {
    let id: String
    let url: String
    let width: Int
    let height: Int
}
