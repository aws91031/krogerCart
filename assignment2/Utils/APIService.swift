//
//  APIService.swift
//  assignment2
//
//  Created by user250993 on 29/03/24.
//

import Foundation
import SwiftyJSON

struct APIService {
    
    func fetchLocations(accessToken: String) async throws -> StoreData {
        
        guard let url = URL(string:  StaticValues.baseUrl + StaticValues.locationsUrl + "?filter.limit=25") else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        
        let (data, _) = try await URLSession.shared.data(for: request)
        
        do {
            let result = try JSONDecoder().decode(StoreData.self, from: data)
            print(result)
        } catch {
            print(error)
        }
        
        let response = try JSONDecoder().decode(StoreData.self, from: data)
        return response
    }
    
    func getProducts(accessToken: String, locationId: String) async throws -> ItemModel {
        
        guard let url = URL(string:  StaticValues.baseUrl + StaticValues.productsUrl + "?filter.term=null&filter.locationId=\(locationId)") else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        
        let (data, _) = try await URLSession.shared.data(for: request)
        
        do {
            let result = try JSONDecoder().decode(ItemModel.self, from: data)
            print(result)
        } catch {
            print(error)
        }
        
        let response = try JSONDecoder().decode(ItemModel.self, from: data)
        return response
    }

    func searchProducts(accessToken: String, locationId: String, search: String? = nil) async throws -> ItemModel? {
        
        guard let url = URL(string:  StaticValues.baseUrl + StaticValues.productsUrl + "?filter.term=\(search ?? "")&filter.locationId=\(locationId)&filter.limit=30") else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        
        let (data, _) = try await URLSession.shared.data(for: request)
        
        do {
            let result = try JSONDecoder().decode(ItemModel.self, from: data)
            print(result)
            return result
        } catch {
            print(error)
            return nil
        }
    }
    
    func getAccessToken() async throws -> TokenResponse {
        let authString = "\(StaticValues.CLIENT_ID):\(StaticValues.CLIENT_SECRET)"
        let authData = authString.data(using: .utf8)
        let authValue = "Basic \(authData?.base64EncodedString() ?? "")"
        
        guard let url = URL(string: StaticValues.baseUrl + StaticValues.authUrl) else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = "grant_type=client_credentials&scope=product.compact".data(using: .utf8)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.setValue(authValue, forHTTPHeaderField: "Authorization")
        
        let (data, _) = try await URLSession.shared.data(for: request)
        let tokenResponse = try JSONDecoder().decode(TokenResponse.self, from: data)
        print("token \(tokenResponse.accessToken)")
        return tokenResponse
    }
    
}
