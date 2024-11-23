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
    @State private var selectedPlace: Model.ID?
    @State private var searchText = ""
    @FocusState private var isSearchFocused
    
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
        .onSubmit(of: .text) { manager.onSearchSubmit(text: searchText) }
        
        .padding(.horizontal)
        .animation(.spring, value: isSearchFocused)
    }

    var body: some View {
        PlacesMap(
            places: manager.places.map { .init($0) },
            selectedMarker: $selectedPlace,
            onSearchTap: manager.onSearchTap
        )
        .ignoresSafeArea(.keyboard)
        .overlay(alignment: .bottom) {
            if !manager.places.isEmpty {
                PlacesHorizontalList(
                    places: manager.places.map { .init($0) },
                    scrollPosition: $selectedPlace,
                    onLastAppear: manager.onLastAppear,
                    isLoading: manager.isLoading
                )
                .transition(.move(edge: .bottom).combined(with: .opacity))
            }
        }
        .safeAreaInset(edge: .top, content: searchBar)
        .animation(.spring, value: selectedPlace)
        .animation(.spring, value: manager.places.isEmpty)
    }
}

#Preview {
    ListedPlacesMap()
}
