//
//  PlayerViewModel.swift
//  Deepening_Profile
//
//  Created by t2023-m0035 on 1/29/24.
//

import Foundation

struct Video: Decodable {
    let id: String
    let title: String
    let thumbnailUrl: String
    let duration: String
    let uploadTime: String
    let views: String
    let author: String
    let videoUrl: String
    let description: String
    let subscriber: String
    let isLive: Bool
}

final class PlayerViewModel {

    static func randomVideo(completion: @escaping (Result<[Video], Error>) -> Void) {
        let session = URLSession.shared
        
        if let url = URL(string: "https://gist.githubusercontent.com/poudyalanil/ca84582cbeb4fc123a13290a586da925/raw/14a27bd0bcd0cd323b35ad79cf3b493dddf6216b/videos.json") {
            
            let task = session.dataTask(with: url) { (data, res, error) in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                else if let data = data {
                    do {
                        let video = try JSONDecoder().decode([Video].self, from: data)
                        completion(.success(video))
                    } catch {
                        completion(.failure(error))
                    }
                }
            }
            
            task.resume()
        }
    }
}
