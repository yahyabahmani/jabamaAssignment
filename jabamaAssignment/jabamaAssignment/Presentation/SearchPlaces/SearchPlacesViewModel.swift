//
//  SearchPlacesViewModel.swift
//  jabamaAssignment
//
//  Created by Amir  on 07/12/2024.
//

import Foundation

@MainActor
final class SearchPlacesViewModel: ObservableObject {
    @Published var query: String = ""
    @Published var places: [Place] = []
    @Published var error: String? = nil
    @Published var isLoading: Bool = false
    @Published var isLoadingMore: Bool = false
    @Published var isSearchMode: Bool = true

    private let searchPlacesUseCase: SearchPlacesUseCaseProtocol

    init(searchPlacesUseCase: SearchPlacesUseCaseProtocol) {
        self.searchPlacesUseCase = searchPlacesUseCase
    }

    func searchPlaces() async {
        isLoading = true
        error = nil
        do {
            let fetchedPlaces = try await searchPlacesUseCase.execute(query: query)
            places = searchPlacesUseCase.filterPlaces(fetchedPlaces, by: query)
        } catch {
            self.error = error.localizedDescription
        }
        isLoading = false
    }

    func loadMorePlaces() async {
        guard !isLoadingMore else { return }
        isLoadingMore = true
        error = nil
        do {
            let morePlaces = try await searchPlacesUseCase.executeNextPage()
            places.append(contentsOf: searchPlacesUseCase.filterPlaces(morePlaces, by: query))
        } catch {
            self.error = error.localizedDescription
        }
        isLoadingMore = false
    }
}
