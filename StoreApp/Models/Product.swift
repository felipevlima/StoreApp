//
//  Product.swift
//  StoreApp
//
//  Created by Felipe Lima on 16/02/23.
//

import Foundation

struct Product: Codable {
    var id: Int?
    let title: String
    let price: Double
    let description: String
    let images: [URL]?
    let category: Category
}
