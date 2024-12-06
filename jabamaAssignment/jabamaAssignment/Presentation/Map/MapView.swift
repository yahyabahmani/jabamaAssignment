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

    init(viewModel: MapViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        ZStack(alignment: .bottom) {
            Map(position: $viewModel.cameraPosition) {
                ForEach(viewModel.places) { place in
                    if let latitude = place.geocodes.main.latitude,
                       let longitude = place.geocodes.main.longitude {
                        Annotation(place.name, coordinate: CLLocationCoordinate2D(latitude: latitude, longitude: longitude)) {
                            VStack {
                                Image(systemName: "mappin.circle.fill")
                                    .foregroundColor(place.id == viewModel.visiblePlaceID ? .blue : .red)
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
            .onChange(of: viewModel.visiblePlaceID) { _, newValue in
                viewModel.updateCameraPosition(for: newValue)
            }
            
            ScrollView(.horizontal) {
                LazyHStack(spacing: 0) {
                    ForEach(viewModel.places) { place in
                        PlaceCardView(place: place)
                            .frame(width: UIScreen.main.bounds.width)
                            .onTapGesture {
                                viewModel.visiblePlaceID = place.id
                            }
                    }
                }
                .scrollTargetLayout()
            }
            .scrollTargetBehavior(.paging)
            .scrollPosition(id: $viewModel.visiblePlaceID)
            .frame(height: 100)
            .background(Color.gray.opacity(0.9))
        }
    }
}


#Preview {
    let mapViewModel = MapViewModel(getPlacesUseCase: MockGetPlacesUseCase())
    MapView(viewModel: mapViewModel)
}

