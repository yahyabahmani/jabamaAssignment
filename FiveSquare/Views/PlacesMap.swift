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
    var locationManager = LocationClient.live
    
    @Binding var selectedMarker: Model.ID?
    var onSearchTap: (_ center: CLLocationCoordinate2D, _ distance: Double) -> Void = { print("Search requested at \($0) d: \($1)") }
    
    @Binding var mapCamera: MapCamera?
    @State private var cameraPosition: MapCameraPosition = .userLocation(fallback: .automatic)
    @State private var showSearchButton = false

    var body: some View {
        Map(position: $cameraPosition, selection: $selectedMarker) {
            ForEach(places) { place in
                Marker(coordinate: place.location) {
                    Text(place.name)
                }
                .tint(.black)
                .tag(place.id)
            }

            UserAnnotation()
        }
        .onMapCameraChange(frequency: .onEnd) { context in
            mapCamera = context.camera
            showSearchButton = true
        }
        .mapControls {
            MapUserLocationButton()
            MapCompass()
        }
        .mapControlVisibility(.visible)
        // The search area button
        .overlay(alignment: .top) {
            if let mapCamera, showSearchButton {
                Button(
                    "Search in this area",
                    systemImage: "magnifyingglass"
                ) {
                    showSearchButton = false
                    onSearchTap(mapCamera.centerCoordinate, mapCamera.distance)
                }
                .font(.subheadline)
                .buttonStyle(.borderedProminent)
                .tint(.black)
                .padding(.top, 8)
                .transition(
                    .asymmetric(
                        insertion: .move(edge: .top).combined(with: .opacity),
                        removal: .opacity
                    )
                )
            }
        }
        .animation(.spring, value: showSearchButton)
        .onAppear { try? locationManager.requestAuthorization() }
        .onChange(of: selectedMarker) {
            if let selectedPlace = places.first(where: { $0.id == selectedMarker }) {
                cameraPosition = .region(
                    .init(
                        center: selectedPlace.location,
                        span: .init(latitudeDelta: 0.015, longitudeDelta: 0.015)
                    )
                )
            }
        }
        .onChange(of: places.isEmpty) {
            guard !places.isEmpty else { return }
            selectedMarker = places.first?.id
        }
        .animation(.default, value: cameraPosition)
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
        selectedMarker: .constant(nil), 
        mapCamera: .constant(nil)
    )
}
