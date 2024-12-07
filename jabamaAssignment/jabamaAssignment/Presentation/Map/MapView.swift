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
    private let searchPlacesViewModelFactory: (String) -> SearchPlacesViewModel
    
    init(
        viewModel: MapViewModel,
        searchPlacesViewModelFactory: @escaping (String) -> SearchPlacesViewModel
    ) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.searchPlacesViewModelFactory = searchPlacesViewModelFactory
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            // Map
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
            
            VStack {
                HStack {
                    Text(viewModel.query.isEmpty ? "Search Places" : viewModel.query)
                        .font(.headline)
                        .foregroundColor(.primary)
                        .padding()
                        .frame(maxWidth: .infinity) // Full width
                        .background(Color(.systemGray6).opacity(0.9))
                        .cornerRadius(10)
                        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 5)
                        .onTapGesture {
                            viewModel.isShowingSearch = true
                        }
                }
                .padding(.horizontal)
                Spacer()
            }
            if !viewModel.places.isEmpty {
                VStack {
                    Spacer()
                    ScrollView(.horizontal, showsIndicators: false) {
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
        .sheet(isPresented: $viewModel.isShowingSearch) {
            let searchViewModel = searchPlacesViewModelFactory(viewModel.query)
            SearchPlacesView(viewModel: searchViewModel) { selectedPlaces, searchedQuery in
                viewModel.places = selectedPlaces
                viewModel.query = searchedQuery
                viewModel.isShowingSearch = false
                viewModel.visiblePlaceID = selectedPlaces.first?.id
            }
        }
    }
}

#Preview {
    let mapViewModel = MapViewModel(getPlacesUseCase: MockGetPlacesUseCase())
    let factory = DependencyFactory()
    MapView(
        viewModel: mapViewModel,
        searchPlacesViewModelFactory: { query in
            factory.makeSearchPlacesViewModel(query: query)
        }
    )
}

