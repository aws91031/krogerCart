//
//  SearchBar.swift
//  assignment2
//
//  Created by user250993 on 15/04/24.
//

import Foundation
import SwiftUI

struct SearchBar: View {
    @Binding var searchText: String
    var searchAction: () -> Void

    var body: some View {
        HStack {
            TextField("Search", text: $searchText)
                .padding(7)
                .padding(.horizontal, 25)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding(.horizontal, 10)
            
            Button(action: searchAction) {
                Image(systemName: "magnifyingglass")
                    .resizable()
                    .frame(width: 16, height: 16)
                    .padding(.trailing, 20)
                    .foregroundColor(.gray)
            }
        }
    }
}
