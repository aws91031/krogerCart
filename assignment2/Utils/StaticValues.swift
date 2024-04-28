//
//  StaticValues.swift
//  assignment2
//
//  Created by user250993 on 29/03/24.
//

import Foundation

struct StaticValues {
    static let baseUrl: String = "https://api.kroger.com/v1"//"https://api.kroger.com/v1/connect/oauth2/token"
    static let locationsUrl = "/locations"
    static let authUrl = "/connect/oauth2/token"
    static let productsUrl = "/products"
    
    static let CLIENT_ID: String = "locationsproject-7a050923070a02e73e0b11fdbc62d2f32213415583486786519"
    static let CLIENT_SECRET: String = "FNxgcjaIQLmonDcvUnWOm0jO9sxibSt-j_FTrXRB"
    static var auth_key: String? = ""
    
    static let CART_ITEM_KEY = "cartItems"
}
