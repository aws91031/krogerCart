//
//  CartItemView.swift
//  assignment2
//
//  Created by user250993 on 20/04/24.
//

import Foundation
import SwiftUI

struct CartItemView: View {
    let item: CartDataModel
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: item.images.first?.sizes.first?.url ?? "")) { img in
                img.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 80,height: 80)
            .cornerRadius(10)
            VStack {
                Text(item.description ?? "")
                HStack {
                    Text("$ \(item.price)")
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
            Spacer()
        }
    }
}
