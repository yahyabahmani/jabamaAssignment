//
//  MapViewModel.swift
//  jabamaAssignment
//
//  Created by Amir  on 05/12/2024.
//

import MapKit
import SwiftUI

@MainActor
final class MapViewModel: ObservableObject {
    @Published var query: String = ""
    @Published var places: [Place] = []
    @Published var error: String? = nil
    @Published var visiblePlaceID: Place.ID?
    @Published var cameraPosition: MapCameraPosition = .region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194),
            span: MKCoordinateSpan(latitudeDelta: 1.05, longitudeDelta: 0.05)
        )
    )
    @Published var isShowingSearch: Bool = false
    @Published var isLoadingMore: Bool = false
    
    private let getPlacesUseCase: GetPlacesUseCaseProtocol

    init(getPlacesUseCase: GetPlacesUseCaseProtocol) {
        self.getPlacesUseCase = getPlacesUseCase
    }

    func searchPlaces() async {
        do {
            places = try await getPlacesUseCase.execute(query: query)
            visiblePlaceID = places.first?.id
            updateCameraPosition(for: visiblePlaceID)
        } catch(let error) {
            self.error = error.localizedDescription
        }
    }

    func updateCameraPosition(for placeID: Place.ID?) {
        guard let placeID = placeID,
              let place = places.first(where: { $0.id == placeID }),
              let latitude = place.geocodes.main.latitude,
              let longitude = place.geocodes.main.longitude else { return }
        cameraPosition = .region(
            MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude),
                span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02) // Adjust zoom level here
            )
        )
    }
    
    func loadMorePlaces() async {
        guard !isLoadingMore else { return }
        isLoadingMore = true
        error = nil
        do {
            let morePlaces = try await getPlacesUseCase.executeNextPage()
            places.append(contentsOf: morePlaces)
        } catch {
            self.error = error.localizedDescription
        }
        isLoadingMore = false
    }
}

