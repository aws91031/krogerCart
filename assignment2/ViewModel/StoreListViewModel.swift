//
//  StoreListViewModel.swift
//  assignment2
//
//  Created by user250993 on 29/03/24.
//

import Foundation
import CoreLocation
import MapKit
import SwiftUI

@MainActor
class StoreListViewModel: ObservableObject {
       
    @Published var storeList: [Datum] = []
    @Published var selectedStore: Datum? = nil
    
    @Published private var cameraPosition: MapCameraPosition? = nil
    
    var selectedStoreCameraPosition: Binding<MKCoordinateRegion>? {
        guard let selectedStore = selectedStore else {
            return nil
        }

        let coordinates = CLLocationCoordinate2D(
            latitude: selectedStore.geolocation.latitude,
            longitude: selectedStore.geolocation.longitude
        )

        let region = MKCoordinateRegion(
            center: coordinates,
            span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        )

        return Binding(
            get: { region },
            set: { newRegion in
                self.cameraPosition = MapCameraPosition.region(newRegion)
            }
        )
    }
    
    private let apiService = APIService()
    
    func fetchLocations(accessToken: String) async {
        do {
            let locationsResponse = try await apiService.fetchLocations(accessToken: accessToken)
            self.storeList = locationsResponse.data
        } catch {
            print("Error fetching locations: \(error.localizedDescription)")
        }
    }
    
    func navigationTitleString(from number: Int) -> String {
        return "Kroger Store \(String(number))"
    }
}
