//
//  ListedPlacesMap.swift
//  FiveSquare
//
//  Created by Shadi Ghelman on 11/23/24.
//

import MapKit
import SwiftUI

struct ListedPlacesMap: View {
    let manager = PlaceManager()
    @State var selectedPlace: Model.ID?

    var body: some View {
        PlacesMap(
            places: manager.places.map { .init($0) },
            selectedMarker: $selectedPlace,
            onSearchTap: manager.onSearchTap
        )
        .overlay(alignment: .bottom) {
            PlacesHorizontalList(
                places: manager.places.map { .init($0) },
                scrollPosition: $selectedPlace,
                onLastAppear: manager.onLastAppear,
                isLoading: manager.isLoading
            )
        }
        .animation(.spring, value: selectedPlace)
    }
}

#Preview {
    ListedPlacesMap()
}
