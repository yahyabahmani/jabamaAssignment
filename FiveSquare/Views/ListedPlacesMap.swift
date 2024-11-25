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
    @State private var isPresentingList = false
    @State private var selectedPlace: Model.ID?
    @State private var searchText = ""
    @FocusState private var isSearchFocused
    @State var mapCamera: MapCamera? = nil

    func searchBar() -> some View {
        HStack {
            Image(systemName: "magnifyingglass")

            TextField("Search", text: $searchText)
                .focused($isSearchFocused)

            Button("Cancel", systemImage: "xmark.circle.fill") {
                searchText = ""
                isSearchFocused = false
            }
            .opacity(isSearchFocused ? 1 : 0)
            .labelStyle(.iconOnly)
            .foregroundStyle(.gray)
        }
        .padding()
        .background(.background, in: .capsule)
        .onTapGesture { isSearchFocused = true }
        .onSubmit(of: .text) {
            guard let mapCamera else { return }
            manager.onSearchSubmit(
                coordinate: mapCamera.centerCoordinate,
                distance: mapCamera.distance,
                text: searchText
            )
        }
        .padding(.horizontal)
        .animation(.spring, value: isSearchFocused)
    }

    private func orientedPlacesList(_ axes: Axis.Set = .horizontal) -> PlacesList {
        PlacesList(
            axes: axes,
            places: manager.places.map { .init($0) },
            scrollPosition: $selectedPlace,
            onLastAppear: manager.onLastAppear,
            isLoading: manager.isLoading
        )
    }

    private func footerView() -> some View {
        orientedPlacesList()
            .safeAreaInset(edge: .top) {
                Button("List Mode", systemImage: "list.bullet") {
                    isPresentingList.toggle()
                }
                .controlSize(.large)
                .bold()
                .buttonStyle(.borderedProminent)
                .frame(maxWidth: .infinity, alignment: .leading)
                .labelStyle(.iconOnly)
                .padding(.horizontal)
                .tint(Color(.systemBackground))
                .foregroundStyle(.primary)
            }
            .padding(.top)
            .transition(.move(edge: .bottom).combined(with: .opacity))
    }

    @ViewBuilder
    func mapContainerView() -> some View {
        if isPresentingList {
            Label("Loading Map...", systemImage: "globe")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .font(.largeTitle)
                .foregroundStyle(.gray)
        } else {
            PlacesMap(
                places: manager.places.map { .init($0) },
                selectedMarker: $selectedPlace,
                onSearchTap: { coordinate, distance in
                    manager.onSearchTap(coordinate: coordinate, distance: distance, text: searchText)
                },
                mapCamera: $mapCamera
            )
            .transition(.opacity)
        }
    }

    var body: some View {
        mapContainerView()
            .animation(.default, value: isPresentingList)
            .ignoresSafeArea(.keyboard)
            .overlay(alignment: .bottom) {
                if !manager.places.isEmpty {
                    footerView()
                }
            }
            .safeAreaInset(edge: .top, content: searchBar)
            .animation(.spring, value: selectedPlace)
            .animation(.spring, value: manager.places.isEmpty)
            .sheet(isPresented: $isPresentingList) {
                orientedPlacesList(.vertical)
                    .presentationDragIndicator(.visible)
                    // Make some room for the presentation drag indicator
                    .padding(.top)
            }
    }
}

#Preview {
    ListedPlacesMap()
}
