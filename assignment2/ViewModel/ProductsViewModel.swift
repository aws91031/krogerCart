//
//  ProductsViewModel.swift
//  assignment2
//
//  Created by user250993 on 09/04/24.
//

import Foundation
import SwiftyJSON

@MainActor
class ProductsViewModel: ObservableObject {
    
    @Published var productList: [ItemDataModel] = []
    @Published var searchProductList: [ItemDataModel] = []
    @Published var selectedProduct: ItemDataModel? = nil
    
    private let apiService = APIService()
    
    func getProducts(accessToken: String, locationId: String) async {
        do {
            let locationsResponse = try await apiService.getProducts(accessToken: accessToken, locationId: locationId)
            self.productList = locationsResponse.data
        } catch {
            print("Error fetching locations: \(error.localizedDescription)")
        }
    }
    
    func searchProducts(accessToken: String, locationId: String, search: String) async {
        do {
            let locationsResponse = try await apiService.searchProducts(accessToken: accessToken, locationId: locationId, search: search)
            if let locationsResponse {
                self.searchProductList = locationsResponse.data
            } else {
                self.searchProductList = []
            }
        } catch {
            print("Error fetching locations: \(error.localizedDescription)")
        }
    }
}
