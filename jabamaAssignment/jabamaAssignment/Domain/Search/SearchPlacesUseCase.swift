//
//  SearchPlacesUseCase.swift
//  jabamaAssignment
//
//  Created by Amir  on 07/12/2024.
//

import Foundation

final class SearchPlacesUseCase: SearchPlacesUseCaseProtocol {
    private let repository: SearchRepositoryProtocol
    
    init(repository: SearchRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(query: String) async throws(NetworkError) -> [Place] {
        return try await repository.getPlaces(query: query)
    }
    
    func filterPlaces(_ places: [Place], by prefix: String) -> [Place] {
        guard !prefix.isEmpty else { return places }
        return places.filter { $0.name.lowercased().hasPrefix(prefix.lowercased()) }
    }
}
