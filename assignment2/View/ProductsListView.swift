//
//  ProductsListView.swift
//  assignment2
//
//  Created by user250993 on 13/04/24.
//

import Foundation
import SwiftUI

struct ProductsListView: View {
    
    @ObservedObject var productsViewModel: ProductsViewModel
    @EnvironmentObject var cartManager: CartManager
    @State private var searchText = ""
    @State private var isSearching = false // Flag to track if search is in progress
    @State private var filteredProducts: [ItemDataModel] = []
    
    let storeId: String
    
    var gridLayout: [GridItem] {
        Array(repeating: GridItem(.flexible(minimum: 150, maximum: 230), spacing: 16), count: 2)
    }
    
    func performSearch() {
        // Set isSearching flag to true when search starts
        isSearching = true
        // Call searchProducts method of ProductsViewModel with search text
        Task {
            await productsViewModel.searchProducts(accessToken: StaticValues.auth_key ?? "", locationId: storeId, search: searchText)
            // Set isSearching flag to false when search is completed
            isSearching = false
        }
    }
    
    var body: some View {
        VStack {
            
            SearchBar(searchText: $searchText, searchAction: performSearch)
            if isSearching {
                Spacer()
                ProgressView() // Show loader while searching
                Spacer()
            } else if !productsViewModel.searchProductList.isEmpty {
                GeometryReader(content: { geo in
                    ScrollView(.vertical, showsIndicators: false) {
                        LazyVGrid(columns: gridLayout, spacing: 8) {
                            ForEach(productsViewModel.searchProductList/*productsViewModel.productList*/) { product in
                                NavigationLink(destination: ProductDetailView(product: product)) {
                                    ProductItemView(product: product, width: (geo.size.width / 2) - 32, height: 245)
                                        .environmentObject(cartManager) // Inject CartManager to ProductItemView
                                        .padding(.horizontal, 0)
                                        .padding(.vertical, 4)
                                }
                            }
                        }
                        .padding(.horizontal, 16)
                        .padding(.bottom, 16)
                        .onAppear {
                            if let accessToken = StaticValues.auth_key {
                                Task {
                                    await productsViewModel.getProducts(accessToken: accessToken, locationId: storeId)
                                }
                            }
                        }
                    }
                })
                
            } else {
                Spacer()
                Text("No Data Found")
                    .padding()
                Spacer()
            }
            
        }
        .navigationTitle("Products") // Set navigation title for NextView
        .navigationBarItems(trailing:
                                NavigationLink(destination: CartView()) {
            Image(systemName: "cart")
                .resizable()
                .frame(width: 30, height: 30)
                .padding()
                .foregroundColor(.blue)
        }
        )
        .onAppear(perform: {
            // Populate filteredProducts with initial products when view appears
            productsViewModel.searchProductList = productsViewModel.productList
        })
    }
}
