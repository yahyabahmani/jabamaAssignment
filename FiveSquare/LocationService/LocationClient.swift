//
//  LocationClient.swift
//  FiveSquare
//
//  Created by Shadi Ghelman on 11/24/24.
//

import Foundation

struct LocationClient {
    var requestAuthorization: () throws -> Void = {
        throw DependencyError.unimplemented
    }
    
    var initialLocation: () throws -> CLLocation = {
        throw DependencyError.unimplemented
    }

    /// Internal errors
    enum DependencyError: Error {
        case unimplemented
    }
}

import CoreLocation

extension LocationClient {
    /// A live instance of the `WebserviceClient`, which interacts with the real API via `Foursquare`.
    static var live: Self {
        LocationClient(
            requestAuthorization: LocationManager.shared.requestAuthorization,
            initialLocation: LocationManager.shared.initialLocation
        )
    }
}
