//
//  assignment2App.swift
//  assignment2
//
//  Created by user250993 on 29/03/24.
//

import SwiftUI

@main
struct assignment2App: App {
    @StateObject private var authViewModel = AuthViewModel()
    
    var body: some Scene {
        WindowGroup {
            StoreListView()
                .environmentObject(authViewModel)
                .environmentObject(CartManager.shared)
        }
    }
}
