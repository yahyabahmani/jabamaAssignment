//
//  ListedPlacesMap.Model.swift
//  FiveSquare
//
//  Created by Shadi Ghelman on 11/23/24.
//

import Foundation
import MapKit

extension ListedPlacesMap {
    struct Model: Identifiable {
        var id: String
        var name: String
        var imageUrl: URL?
        var type: String?
        var distance: Int?
        var location: CLLocationCoordinate2D
    }
}
