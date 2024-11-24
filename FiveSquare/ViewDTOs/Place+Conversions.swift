//
//  ListedPlacesMap+ModelConversions.swift
//  FiveSquare
//
//  Created by Shadi Ghelman on 11/23/24.
//

import Foundation

/// Listed places convenience initializer
extension PlacesMap.Model {
    init(_ place: Place) {
        self.init(
            id: place.fsqId,
            location: .init(
                latitude: place.geocodes.main.latitude,
                longitude: place.geocodes.main.longitude
            ),
            name: place.name
        )
    }
}

/// Listed places convenience initializer
extension PlaceCard.Model {
    init(_ place: Place) {
        func imageUrl() -> URL? {
            guard let firstPhoto = place.photos?.first else { return nil }
            guard let prefix = firstPhoto.prefix else { return nil }
            let raw = prefix + "120" + firstPhoto.suffix
            return URL(string: raw)
        }
        
        self.init(
            id: place.fsqId,
            imageUrl: imageUrl(),
            name: place.name,
            type: place.categories?.first?.name,
            distance: place.distance
        )
    }
}
