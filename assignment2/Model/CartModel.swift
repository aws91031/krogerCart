//
//  CartModel.swift
//  assignment2
//
//  Created by user250993 on 20/04/24.
//

import Foundation

struct CartModel: Codable {
    let data: [CartDataModel]
}

struct CartDataModel: Codable, Identifiable, Equatable {
    
    var id: String // Conforming to Identifiable protocol
    let brand: String
    let description: String?
    var price: Int

    let images: [ItemImageModel]
    
    enum CodingKeys: String, CodingKey {
        case brand, description, images, price
        case id = "productId"
    }
    
    // Implementing Equatable
    static func ==(lhs: CartDataModel, rhs: CartDataModel) -> Bool {
        return lhs.id == rhs.id
    }
}

//struct ItemImageModel: Codable {
//    let perspective: String
//    let sizes: [ItemSize]
//}
//
//struct ItemSize: Codable {
//    let size: String
//    let url: String
//}
