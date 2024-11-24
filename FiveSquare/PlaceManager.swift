//
//  PlacesManager.swift
//  FiveSquare
//
//  Created by Shadi Ghelman on 11/23/24.
//

import Foundation
import MapKit
import Observation

@Observable
class PlaceManager {    
    var webservice: WebserviceClient = .live

    var places: [Place] = []

    var isLoading: Bool { task?.isCancelled == false }
    var task: Task<Void, Error>?
    var nextURL: URL?

    func onLastAppear() {
        guard task == nil else { return }
        guard let nextURL else { return }

        task = Task {
            defer { task = nil }
            let (placesList, nextURL) = try await webservice.getPlacesNextPage(nextURL)
            places.append(contentsOf: placesList)
            self.nextURL = nextURL
        }
    }

    func onSearchTap(coordinate: CLLocationCoordinate2D, distance: Double, text: String) {
        task?.cancel()
        places = []

        task = Task {
            defer { task = nil }
            let coordinate = "\(coordinate.latitude),\( coordinate.longitude)"
            let distance = Int(distance)
            (places, nextURL) = try await webservice.getPlaces(
                coordinate: coordinate,
                radius: distance,
                query: text
            )
        }
    }
    
    func onSearchSubmit(coordinate: CLLocationCoordinate2D, distance: Double, text: String) {
        task?.cancel()
        places = []

        task = Task {
            defer { task = nil }
            let coordinate = "\(coordinate.latitude),\( coordinate.longitude)"
            let distance = Int(distance)
            (places, nextURL) = try await webservice.getPlaces(
                coordinate: coordinate,
                radius: distance,
                query: text
            )
        }
    }
}
