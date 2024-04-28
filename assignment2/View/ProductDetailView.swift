//
//  ProductDetailView.swift
//  assignment2
//
//  Created by user250993 on 15/04/24.
//

import Foundation
import SwiftUI

struct ProductDetailView: View {
    
    @EnvironmentObject var cartManager: CartManager
    
    let product: ItemDataModel
    var cartObj: CartDataModel
    
    init(product: ItemDataModel) {
        self.product = product
        
        cartObj = CartDataModel(id: product.id, brand: product.brand, description: product.description, price: product.price, images: product.images)
    }
    
    var body: some View {
        VStack {
            
            AsyncImage(url: URL(string: product.images.first?.sizes.first?.url ?? "")) { img in
                img.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 200,height: 200)
            .cornerRadius(10)
            .padding(.top, 15)
            .padding(.top, 12)
            
            // Display product details
            HStack {
                Text("\(product.brand)")
                    .fontWeight(.semibold)
                    .font(.title)
                    .frame(width: 300, alignment: .leading)
                    .truncationMode(.tail)
                Spacer()
            }
            .padding(.horizontal, 15)
            
            HStack {
                Text("\(product.description ?? "")")
                    .frame(width: 300, alignment: .leading)
                    .lineLimit(1)
                    .truncationMode(.tail)
                Spacer()
            }
            .padding(.horizontal, 15)
            
            HStack {
                Text("$ \(product.price)")
                    .font(.subheadline)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
                    .padding(.bottom, 2)
                    .padding(.top, 0)
                Spacer()
            }
            .padding(.horizontal, 15)
            
            Spacer()
            
            // Add to cart button
            Button(action: {
                
                // Add the product to the cart
                if !cartManager.isProductAdded(cartObj) {
                    cartManager.addItemToCart(cartObj)
                }
            }) {
                
                HStack {
                    Image(systemName: "cart")
                    Text(cartManager.isProductAdded(cartObj) ? "Added" : "Add to Cart")
                }
                .disabled(cartManager.isProductAdded(cartObj)) // Disable button if product is already added
                .padding()
                .foregroundColor(.white)
                .background(Color.blue)
                .cornerRadius(8)
            }
            .padding()
        }
        .navigationTitle("Product Detail") // Set product name as navigation title
        .navigationBarItems(trailing:
                                NavigationLink(destination: CartView()) {
            Image(systemName: "cart")
                .resizable()
                .frame(width: 30, height: 30)
                .padding()
                .foregroundColor(.blue)
        }
        )
    }
}
