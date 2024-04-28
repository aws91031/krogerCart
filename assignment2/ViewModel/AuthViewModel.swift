//
//  AuthViewModel.swift
//  assignment2
//
//  Created by user250993 on 30/03/24.
//

import Foundation

class AuthViewModel: ObservableObject {
    @Published var accessToken: String? {
        didSet {
            if let accessToken = accessToken {
                // Store the access token in a local property or UserDefaults
                storedAccessToken = accessToken
            }
        }
    }
    
    public var storedAccessToken: String?
    @Published var error: Error?
    private let apiService = APIService()
    
    func getAccessToken() async {
        do {
            let tokenResponse = try await apiService.getAccessToken()
            self.accessToken = tokenResponse.accessToken
            StaticValues.auth_key = self.accessToken ?? ""
            self.error = nil
        } catch {
            self.accessToken = nil
            self.error = error
        }
    }
}
