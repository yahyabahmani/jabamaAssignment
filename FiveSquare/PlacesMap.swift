//
//  PlacesMap.swift
//  FiveSquare
//
//  Created by Shadi Ghelman on 11/23/24.
//

import MapKit
import SwiftUI

struct PlacesMap: View {
    var places: [Model]

    @Binding var selectedMarker: Model.ID?
    @State private var camera: MapCameraPosition = .userLocation(fallback: .automatic)
        
    var body: some View {
        Map(position: $camera, selection: $selectedMarker) {
            ForEach(places) { place in
                Marker(coordinate: place.location) {
                    Text(place.name)
                }
                .tint(.black)
                .tag(place.id)
            }

            UserAnnotation()
        }
        .mapControls {
            MapUserLocationButton()
            MapCompass()
        }
        .mapControlVisibility(.visible)
    }
}

#Preview {
    PlacesMap(
        places: (1...10).map {
            let randomName = UUID().uuidString.prefix(Int.random(in: 5...15))
            return .init(
                id: "\($0)",
                location: .init(
                    latitude: .random(in: 25...40),
                    longitude: .random(in: 48...60)
                ),
                name: String(randomName)
            )
        },
        selectedMarker: .constant(nil)
    )
}
