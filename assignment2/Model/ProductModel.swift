//
//  ProductModel.swift
//  assignment2
//
//  Created by user250993 on 15/04/24.
//
import Foundation

struct ItemModel: Codable {
    let data: [ItemDataModel]
}

struct ItemDataModel: Codable, Identifiable, Equatable {
    
    var id: String // Conforming to Identifiable protocol
    let brand: String
    let description: String?
    let price: Int = Int.random(in: 1 ..< 10)

    let images: [ItemImageModel]
    
    enum CodingKeys: String, CodingKey {
        case brand, description, images
        case id = "productId"
    }
    
    // Implementing Equatable
    static func ==(lhs: ItemDataModel, rhs: ItemDataModel) -> Bool {
        return lhs.id == rhs.id
    }
}

struct ItemImageModel: Codable {
    let perspective: String
    let sizes: [ItemSize]
}

struct ItemSize: Codable {
    let size: String
    let url: String
}
