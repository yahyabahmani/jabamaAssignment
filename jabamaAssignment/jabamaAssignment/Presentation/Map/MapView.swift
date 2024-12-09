//
//  MapView.swift
//  jabamaAssignment
//
//  Created by Amir  on 05/12/2024.
//

import SwiftUI
import MapKit

struct MapView: View {
    // MARK: - Properties
    @StateObject private var viewModel: MapViewModel
    private let searchPlacesViewModelFactory: SearchPlacesViewModel
    
    // MARK: - Initializer
    init(
        viewModel: MapViewModel,
        searchPlacesViewModelFactory: SearchPlacesViewModel
    ) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.searchPlacesViewModelFactory = searchPlacesViewModelFactory
    }
    
    // MARK: - Body
    var body: some View {
        ZStack(alignment: .top) {
            // MARK: - Map View
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
            
            // MARK: - Search Bar
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
            
            // MARK: - Places Carousel
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
                                    .onAppear {
                                        if place.id == viewModel.places.last?.id && viewModel.places.count >= 10 {
                                            Task {
                                                await viewModel.loadMorePlaces()
                                            }
                                        }
                                    }
                            }
                        }
                        .scrollTargetLayout()
                    }
                    .scrollTargetBehavior(.paging)
                    .scrollPosition(id: $viewModel.visiblePlaceID)
                    .frame(height: 100)
                    .background(Color.gray.opacity(0.9))
                    .overlay {
                        if viewModel.isLoadingMore {
                            // MARK: - Loading More Overlay
                            ZStack {
                                Color.black.opacity(0.4)
                                    .ignoresSafeArea()
                                ProgressView("Loading more...")
                                    .padding()
                                    .background(Color.white.opacity(0.9))
                                    .cornerRadius(10)
                                    .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 5)
                                    .foregroundColor(.primary)
                                    .font(.headline)
                            }
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                        }
                    }
                }
            }
            
            // MARK: - Error View
            if let errorMessage = viewModel.error {
                NetworkErrorView(
                    errorMessage: errorMessage,
                    onRetry: {
                        Task {
                            viewModel.error = nil
                            await viewModel.searchPlaces()
                        }
                    }
                )
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.black.opacity(0.5))
                .transition(.opacity)
            }
        }
        
        // MARK: - Search Sheet
        .sheet(isPresented: $viewModel.isShowingSearch) {
            SearchPlacesView(viewModel: searchPlacesViewModelFactory) { selectedPlaces in
                viewModel.places = selectedPlaces
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
        searchPlacesViewModelFactory: factory.makeSearchPlacesViewModel()
    )
}

