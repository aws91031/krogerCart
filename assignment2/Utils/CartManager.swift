//
//  CartManager.swift
//  assignment2
//
//  Created by user250993 on 20/04/24.
//

import Foundation

class CartManager: ObservableObject {
    
    static let shared = CartManager()
    
    @Published var cartItems: [CartDataModel] {
        didSet {
            saveCartItems()
        }
    }
    
    private init() {
        self.cartItems = CartManager.loadCartItems()
    }
    
    // Load Existing data or empty list
    private static func loadCartItems() -> [CartDataModel] {
        if let data = UserDefaults.standard.data(forKey: StaticValues.CART_ITEM_KEY) {
            if let decoded = try? JSONDecoder().decode([CartDataModel].self, from: data) {
                return decoded
            }
        }
        return []
    }
    
    // Save data
    private func saveCartItems() {
        if let encoded = try? JSONEncoder().encode(cartItems) {
            UserDefaults.standard.set(encoded, forKey: StaticValues.CART_ITEM_KEY)
        }
    }
    
    // Add to list
    func addItemToCart(_ item: CartDataModel) {
        cartItems.append(item)
    }
    
    // Delete data
    func removeItemFromCart(_ item: CartDataModel) {
        if let index = cartItems.firstIndex(of: item) {
            cartItems.remove(at: index)
        }
    }
    
    // Existing properties and methods
    func isProductAdded(_ product: CartDataModel) -> Bool {
        return cartItems.contains(product)
    }
}
