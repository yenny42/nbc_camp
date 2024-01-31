//
//  ImageLoader.swift
//  Deepening_Profile
//
//  Created by t2023-m0035 on 1/24/24.
//

import UIKit

final class ImageLoader {
    static func loadImage(from url: String, completion: @escaping (Result<UIImage?, Error>) -> Void) {
        if let imageURL = URL(string: url) {
            let task = URLSession.shared.dataTask(with: imageURL) { (data, _, error) in
                if let error = error {
                    completion(.failure(error))
                }
                else if let imageData = data {
                    let image = UIImage(data: imageData)
                    
                    completion(.success(image))
                }
            }
            task.resume()
        }
    }
}
