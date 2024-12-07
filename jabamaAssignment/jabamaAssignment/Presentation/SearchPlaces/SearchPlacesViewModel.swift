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
    @Published var isSearchMode: Bool = true
    
    private let searchPlacesUseCaseProtocol: SearchPlacesUseCaseProtocol
    
    init(searchPlacesUseCaseProtocol: SearchPlacesUseCaseProtocol, initialQuery: String? = nil) {
        self.searchPlacesUseCaseProtocol = searchPlacesUseCaseProtocol
        if let initialQuery = initialQuery {
            self.query = initialQuery
        }
    }
    
    func searchPlaces() async {
        isLoading = true
        error = nil
        do {
            let fetchedPlaces = try await searchPlacesUseCaseProtocol.execute(query: query)
            places = searchPlacesUseCaseProtocol.filterPlaces(fetchedPlaces, by: query)
        } catch(let error) {
            self.error = error.localizedDescription
        }
        isLoading = false
    }
}
