//
//  MapView.swift
//  jabamaAssignment
//
//  Created by Amir  on 05/12/2024.
//

import SwiftUI
import MapKit

struct MapView: View {
    @StateObject private var viewModel: MapViewModel
    @State private var cameraPosition: MapCameraPosition = .region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194),
            span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        )
    )

    init(viewModel: MapViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        ZStack {
            Map(position: $cameraPosition) {
                ForEach(viewModel.places) { place in
                    if let latitude = place.geocodes.main.latitude,
                       let longitude = place.geocodes.main.longitude {
                        Annotation(place.name, coordinate: CLLocationCoordinate2D(latitude: latitude, longitude: longitude)) {
                            VStack {
                                Image(systemName: "mappin.circle.fill")
                                    .foregroundColor(.red)
                                    .font(.largeTitle)
                                Text(place.name)
                                    .font(.caption)
                                    .foregroundColor(.primary)
                            }
                        }
                    }
                }
            }
            .ignoresSafeArea()
            .onAppear {
                Task {
                    await viewModel.searchPlaces()
                }
            }
            .onReceive(viewModel.$places) { newPlaces in
                if let firstPlace = newPlaces.first,
                   let latitude = firstPlace.geocodes.main.latitude,
                   let longitude = firstPlace.geocodes.main.longitude {
                    cameraPosition = .region(
                        MKCoordinateRegion(
                            center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude),
                            span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
                        )
                    )
                }
            }

            // Show error if any
            if let error = viewModel.error {
                Text("Error: \(error)")
                    .padding()
                    .background(Color.red.opacity(0.8))
                    .cornerRadius(10)
                    .foregroundColor(.white)
                    .padding()
            }
        }
    }
}


#Preview {
    let networkManager = NetworkManager()
    let mapRepository = MapRepository(networkManager: networkManager)
    let getPlacesUseCase = GetPlacesUseCase(repository: mapRepository)
    let mapViewModel = MapViewModel(getPlacesUseCase: getPlacesUseCase)
    MapView(viewModel: mapViewModel)
}
