//
//  StoreListModel.swift
//  assignment2
//
//  Created by user250993 on 29/03/24.
//

import Foundation

// MARK: - StoreData
struct StoreData: Codable {
    let data: [Datum]
}

// MARK: - Datum
struct Datum: Codable, Identifiable {
    let id: String
    let storeNumber, divisionNumber, chain: String
    let address: Address
    let geolocation: Geolocation
    let name: String
    let phone: String
    let departments: [Department]

    enum CodingKeys: String, CodingKey {
        case id = "locationId"
        case storeNumber, divisionNumber, chain, address, geolocation, name, phone, departments
    }
}

// MARK: - Address
struct Address: Codable {
    let addressLine1, city, state, zipCode: String
    let county: String?
}

// MARK: - Department
struct Department: Codable {
    let departmentID, name: String
    let phone: String?
    let address: Address?
    let geolocation: Geolocation?
    let offsite: Bool?

    enum CodingKeys: String, CodingKey {
        case departmentID = "departmentId"
        case name, phone, address, geolocation, offsite
    }
}

// MARK: - Geolocation
struct Geolocation: Codable {
    let latitude, longitude: Double
    let latLng: String
}
