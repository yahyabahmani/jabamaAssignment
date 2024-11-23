//
//  PlacesMap.Model.swift
//  FiveSquare
//
//  Created by Shadi Ghelman on 11/23/24.
//

import Foundation
import MapKit

extension PlacesMap {
    struct Model: Identifiable {
        var id: String
        var location: CLLocationCoordinate2D
        var name: String
    }
}
