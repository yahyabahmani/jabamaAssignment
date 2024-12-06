//
//  GetPlacesUseCase.swift
//  jabamaAssignment
//
//  Created by Amir  on 05/12/2024.
//

import Foundation

protocol GetPlacesUseCaseProtocol {
    func execute(query: String) async throws(NetworkError) -> [Place]
}

final class GetPlacesUseCase: GetPlacesUseCaseProtocol {
    private let repository: MapRepositoryProtocol
    
    init(repository: MapRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(query: String) async throws(NetworkError) -> [Place] {
        return try await repository.getPlaces(query: query)
    }
}
