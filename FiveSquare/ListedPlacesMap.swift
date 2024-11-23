//
//  ListedPlacesMap.swift
//  FiveSquare
//
//  Created by Shadi Ghelman on 11/23/24.
//

import MapKit
import SwiftUI

struct ListedPlacesMap: View {
    let places: [Model]
    
    var body: some View {
        PlacesMap(places: places.map { .init($0) })
            .overlay(alignment: .bottom) {
                PlacesHorizontalList(places: places.map { .init($0) })
            }
    }
}

#Preview {
    ListedPlacesMap(
        places: (1...10).map {
            let randomName = UUID().uuidString.prefix(Int.random(in: 5...15))

            return .init(
                id: "\($0)",
                name: String(randomName),
                type: "Restaurant",
                distance: $0 * 10,
                location: .init(
                    latitude: .random(in: 25...40),
                    longitude: .random(in: 48...60)
                )
            )
        }
    )
}
