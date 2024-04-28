//
//  ProductItemView.swift
//  assignment2
//
//  Created by user250993 on 11/04/24.
//

import Foundation
import SwiftUI

struct ProductItemView: View {
    let product: ItemDataModel
    let width: CGFloat
    let height: CGFloat
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: product.images.first?.sizes.first?.url ?? "")) { img in
                img.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 150,height: 150)
            .cornerRadius(10)

            Text(product.brand)
                .font(.headline)
                .foregroundStyle(.black)
                .multilineTextAlignment(.leading)
                .padding(.horizontal,15)
            
            Text(product.description ?? "")
                .foregroundStyle(.gray.opacity(0.9))
                .font(.subheadline)
                .lineLimit(2)
                .multilineTextAlignment(.leading)
                .padding(.horizontal, 15)
                .padding(.bottom, 1)
                .padding(.top, 0)
            
            HStack {
                Text("$ \(product.price)")
                    .foregroundStyle(.black)
                    .font(.subheadline)
                    .lineLimit(1)
                    .multilineTextAlignment(.leading)
                    .padding(.bottom, 2)
                    .padding(.top, 0)
                Spacer()
            }
            .padding(.horizontal, 15)
            
        }
        .frame(width: width, height: height)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}

struct ProductItemView_Previews: PreviewProvider {
    static var previews: some View {
        
        return ProductItemView(product: ItemDataModel(id: "", brand: "Name", description: "Product", images: [ItemImageModel(perspective: "", sizes: [ItemSize(size: "", url: "https://www.kroger.com/product/images/xlarge/front/0003750457137")])]), width: 200, height: 250)
    }
}
