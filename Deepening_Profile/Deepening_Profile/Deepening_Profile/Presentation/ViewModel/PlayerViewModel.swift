//
//  PlayerViewModel.swift
//  Deepening_Profile
//
//  Created by t2023-m0035 on 1/31/24.
//

import Foundation

class PlayerViewModel {
    var data: [Video] = []

    func fetchData(completion: @escaping (Result<[Video], Error>) -> Void) {
        if data.isEmpty {
            PlayerVideoAPI.getVideo { result in
                switch result {
                case .success(let video):
                    self.data = video
                    completion(.success(video))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        } else {
            completion(.success(data))
        }
    }
}
