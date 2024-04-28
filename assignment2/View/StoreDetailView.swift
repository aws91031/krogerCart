//
//  StoreDetailView.swift
//  assignment2
//
//  Created by user250993 on 30/03/24.
//

import SwiftUI
import MapKit

struct StoreDetailView: View {
    
    @ObservedObject var viewModel: StoreListViewModel
    @StateObject private var productsViewModel = ProductsViewModel()
    
    var accessToken: String
    
    var gridLayout: [GridItem] {
        Array(repeating: GridItem(.fixed(200), spacing: 16), count: 1)
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment:.leading) {
                
                if let store = viewModel.selectedStore {
                    
                    Text("\(store.address.addressLine1) \(store.address.city) \(store.address.state)")
                        .font(.system(size: 17,weight: .medium))
                        .frame(maxWidth: 240, alignment: .leading)
                        .fixedSize(horizontal: true, vertical: false)
                        .padding(.leading, 17)
                        .padding(.top, 15)
                        .padding(.bottom, 15)
                    if let cameraPosition = viewModel.selectedStoreCameraPosition {
                        Map(coordinateRegion: cameraPosition, annotationItems: [store]) { store in
                            MapMarker(coordinate: CLLocationCoordinate2D(latitude: store.geolocation.latitude, longitude: store.geolocation.longitude))
                        }
                        .frame(height: 280)
                    }
                    
                    HStack {
                        
                        Image(systemName: "phone")
                            .foregroundColor(.black)
                            .padding(EdgeInsets(top: 10, leading: 12, bottom: 10, trailing: 2))
                        Text(store.phone)
                            .foregroundColor(.black)
                            .font(.callout)
                            .padding(EdgeInsets(top: 0, leading: 2, bottom: 0, trailing: 12))
                        
                    }
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.blue, lineWidth: 1.5)
                    )
                    .padding(EdgeInsets(top: 2, leading: 12, bottom: 1, trailing: 0))
                    
                    
                    HStack {
                        
                        Text("Products")
                            .fontWeight(.medium)
                            .font(.subheadline)
                            .padding(.horizontal, 8)
                        
                        Spacer()
                        
                        NavigationLink(destination: ProductsListView(productsViewModel: productsViewModel, storeId: viewModel.selectedStore?.id ?? "")) {
                            Text("View All")
                                .padding(.horizontal)
                                .foregroundColor(.blue)
                                .cornerRadius(10)
                        }
                        
                    }
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHGrid(rows: gridLayout, spacing: 16) {
                            ForEach(productsViewModel.productList) { product in
                                NavigationLink(destination: ProductDetailView(product: product)) {
                                    ProductItemView(product: product, width: 200, height: 250)
                                }
                            }
                        }
                        .padding()
                        .onAppear {
                            if let accessToken = StaticValues.auth_key, let selectedStore = viewModel.selectedStore {
                                Task {
                                    await productsViewModel.getProducts(accessToken: accessToken, locationId: selectedStore.id)
                                }
                            }
                        }
                    }
                    
                } else {
                    Text("No store selected")
                    
                }
            }
            .onAppear(perform: {
                Task {
                    await productsViewModel.getProducts(accessToken: accessToken, locationId: viewModel.selectedStore?.id ?? "")
                }
            })
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
            .navigationBarTitle(Text("Kroger Store \(viewModel.selectedStore?.storeNumber ?? "-")"))
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
}

struct StoreDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = StoreListViewModel()
        
        return StoreDetailView(viewModel: viewModel, accessToken: "")
    }
}
