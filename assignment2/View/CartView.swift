//
//  CartView.swift
//  assignment2
//
//  Created by user250993 on 20/04/24.
//

import Foundation
import SwiftUI


struct CartView: View {
    @StateObject private var cartManager = CartManager.shared
    
    var body: some View {
        VStack {
            if cartManager.cartItems.isEmpty {
                Text("Your cart is empty")
                    .padding()
            } else {
                List {
                    ForEach(cartManager.cartItems) { item in
                        CartItemView(item: item)
//                        CartItemView(item: item)
                    }
                    .onDelete(perform: deleteProduct)
                }
                .listStyle(PlainListStyle())
                Spacer()
                HStack {
                    Text("Sub Total: \(cartManager.cartItems.map { $0.price ?? 999 }.reduce(0, +))")
                        .font(.title)
                }
            }
        }
        .navigationTitle("Cart")
    }
    
    private func deleteProduct(at offsets: IndexSet) {
        cartManager.cartItems.remove(atOffsets: offsets)
    }
}
