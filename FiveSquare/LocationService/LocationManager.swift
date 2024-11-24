//
//  LocationManager.swift
//  FiveSquare
//
//  Created by Shadi Ghelman on 11/24/24.
//

import Foundation
import CoreLocation

class LocationManager {
    static let shared = LocationManager()
    
    private let manager = CLLocationManager()
    
    public func requestAuthorization() {
        manager.requestWhenInUseAuthorization()
    }
    
    private let defaultLocation = CLLocation(latitude: 35.711600, longitude: 51.407010)
    
    public func initialLocation() -> CLLocation {
        manager.location ?? defaultLocation
    }
}
