//
//  DeleteProductReponse.swift
//  StoreApp
//
//  Created by Felipe Lima on 21/02/23.
//

import Foundation

struct DeleteProductReponse: Decodable {
    var rta: Bool?
    var statusCode: Int?
    var message: String?
    var error: String?
}
