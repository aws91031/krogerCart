//
//  StoreListView.swift
//  assignment2
//
//  Created by user250993 on 29/03/24.
//

import SwiftUI

struct StoreListView: View {
    
    @EnvironmentObject private var authViewModel: AuthViewModel
    @StateObject private var locationsViewModel = StoreListViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                if let error = authViewModel.error {
                    Text("Error: \(error.localizedDescription)")
                } else if let accessToken = authViewModel.accessToken {
                    LocationsView(accessToken: accessToken)
                        .environmentObject(authViewModel)
                } else {
                    ProgressView()
                        .task {
                            await authViewModel.getAccessToken()
                        }
                }
            }
        }
    }
}

struct LocationsView: View {
    @StateObject private var viewModel = StoreListViewModel()
    @EnvironmentObject private var authViewModel: AuthViewModel
    @State private var selectedIndex: Int?
    var accessToken: String
    
    var body: some View {
        NavigationView {
            Group {
                if viewModel.storeList.isEmpty {
                    
                    ProgressView()
                        .onAppear {
                            Task {
                                await viewModel.fetchLocations(accessToken: accessToken)
                            }
                        }
                    
                } else {
                    List(viewModel.storeList.indices, selection: $selectedIndex) { index in
                        NavigationLink(destination: StoreDetailView(viewModel: viewModel, accessToken: accessToken).environmentObject(authViewModel)) {
                            VStack(alignment: .leading) {
                                Text("Store \(viewModel.storeList[index].storeNumber)")
                            }
                        }
                    }
                    .onChange(of: selectedIndex) {
                        if let index = $0 {
                            viewModel.selectedStore = viewModel.storeList[index]
                        }
                    }
                }
            }
            .navigationTitle("Kroger Stores")
        }
    }
}

struct StoreListView_Previews: PreviewProvider {
    static var previews: some View {
        StoreListView()
    }
}
