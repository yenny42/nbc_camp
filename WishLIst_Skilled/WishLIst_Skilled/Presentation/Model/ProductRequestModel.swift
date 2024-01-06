//
//  ProductRequestModel.swift
//  WishLIst_Skilled
//
//  Created by t2023-m0035 on 1/5/24.
//

import Foundation

struct Product: Decodable {
    let id: Int
    let title: String
    let description: String
    let price: Int
    let brand: String
    let thumbnail: String
}
