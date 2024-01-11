//
//  RandomDogRequest.swift
//  Skilled_MyTodoList
//
//  Created by t2023-m0035 on 1/9/24.
//

import Foundation

final class RandomDogRequest {
    static func decodeRandomDog(completion: @escaping (Result<RandomDog, Error>) -> Void) {
        if let url = URL(string: "https://api.thedogapi.com/v1/images/search") {
            let task = URLSession.shared.dataTask(with: url) { (data, res, error) in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                else if let data = data {
                    do {
                        let randomDogArr = try JSONDecoder().decode([Dog].self, from: data)
                        let randomDog = RandomDog(dog: randomDogArr)
                        completion(.success(randomDog))
                    } catch {
                        completion(.failure(error))
                    }
                }
            }
            
            task.resume()
        }
    }
}
