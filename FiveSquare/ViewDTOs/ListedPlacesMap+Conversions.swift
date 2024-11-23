//
//  ListedPlacesMap+ModelConversions.swift
//  FiveSquare
//
//  Created by Shadi Ghelman on 11/23/24.
//

/// Listed places convenience initializer
extension PlacesMap.Model {
    init(_ listedPlaces: ListedPlacesMap.Model) {
        self.init(
            id: listedPlaces.id,
            location: listedPlaces.location,
            name: listedPlaces.name
        )
    }
}

/// Listed places convenience initializer
extension PlaceCard.Model {
    init(_ listedPlaces: ListedPlacesMap.Model) {
        self.init(
            id: listedPlaces.id,
            imageUrl: listedPlaces.imageUrl,
            name: listedPlaces.name,
            type: listedPlaces.type,
            distance: listedPlaces.distance
        )
    }
}
