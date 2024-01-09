//
//  ImageLoader.swift
//  Skilled_MyTodoList
//
//  Created by t2023-m0035 on 1/9/24.
//

import UIKit

class ImageLoader {
    static func loadImage(from url: String, into imageView: UIImageView, completion: (() -> Void)? = nil) {
        if let imageURL = URL(string: url) {
            let task = URLSession.shared.dataTask(with: imageURL) { (data, _, error) in
                if let error = error {
                    print("Error loading image: \(error.localizedDescription)")
                    return
                }
                else if let imageData = data, let image = UIImage(data: imageData) {
                    DispatchQueue.main.async {
                        imageView.backgroundColor = .clear
                        imageView.image = image
                        completion?()
                    }
                }
            }
            task.resume()
        }
    }
}
