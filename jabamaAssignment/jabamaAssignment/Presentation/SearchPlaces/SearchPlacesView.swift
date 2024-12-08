//
//  SearchPlaces.swift
//  jabamaAssignment
//
//  Created by Amir  on 07/12/2024.
//

import SwiftUI

struct SearchPlacesView: View {
    @StateObject private var viewModel: SearchPlacesViewModel
    var onShowOnMap: ([Place], String) -> Void

    init(viewModel: SearchPlacesViewModel, onShowOnMap: @escaping ([Place], String) -> Void) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.onShowOnMap = onShowOnMap
    }

    var body: some View {
        ZStack {
            VStack {
                TextField("Search for places", text: $viewModel.query)
                    .onChange(of: viewModel.query) { _, _ in
                        viewModel.isSearchMode = true
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 5)
                    .padding(.horizontal)
                    .submitLabel(.search)
                    .onSubmit {
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                        Task {
                            await viewModel.searchPlaces()
                            viewModel.isSearchMode = false
                        }
                    }

                Spacer(minLength: 20)

                if viewModel.isLoading {
                    ProgressView("Searching...")
                        .padding()
                } else if viewModel.places.isEmpty {
                    VStack(spacing: 16) {
                        Text("No results found")
                            .foregroundColor(.gray)
                            .font(.headline)

                        Image(systemName: "magnifyingglass")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80, height: 80)
                            .foregroundColor(.gray.opacity(0.5))
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    ScrollView {
                        LazyVStack(spacing: 10) {
                            ForEach(viewModel.places) { place in
                                PlaceCardView(place: place)
                                    .onAppear {
                                        if place.id == viewModel.places.last?.id && viewModel.places.count >= 10 {
                                            Task {
                                                await viewModel.loadMorePlaces()
                                            }
                                        }
                                    }
                            }
                            if viewModel.isLoadingMore {
                                ProgressView("Loading more...")
                                    .padding()
                            }
                        }
                        .padding(.top, 10)
                    }
                }

                Spacer()

                if !viewModel.places.isEmpty || viewModel.isSearchMode {
                    Button(action: {
                        if viewModel.isSearchMode {
                            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                            Task {
                                await viewModel.searchPlaces()
                                viewModel.isSearchMode = false
                            }
                        } else {
                            onShowOnMap(viewModel.places, viewModel.query)
                        }
                    }) {
                        Text(viewModel.isSearchMode ? "Search" : "Show on Map")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(viewModel.isSearchMode ? Color.blue : Color.orange)
                            .cornerRadius(10)
                            .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 5)
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 10)
                }
            }
            .padding(.top, 16)

            // Network Error View
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
    }
}

#Preview {
    let searchPlacesViewModel = SearchPlacesViewModel(searchPlacesUseCase: MockGetSearchPlacesUseCase())
    SearchPlacesView(viewModel: searchPlacesViewModel) { places, searchedText  in
        print("Selected places to show on map: \(places)")
    }
}
