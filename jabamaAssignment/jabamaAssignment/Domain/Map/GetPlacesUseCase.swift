//
//  GetPlacesUseCase.swift
//  jabamaAssignment
//
//  Created by Amir  on 05/12/2024.
//

import Foundation

final class GetPlacesUseCase: GetPlacesUseCaseProtocol {
    private let repository: MapRepositoryProtocol
    
    init(repository: MapRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(query: String) async throws -> [Place] {
        return try await repository.getPlaces(query: query)
    }
    
    func executeNextPage() async throws -> [Place] {
        return try await repository.getPlaces(query: "")
    }
}
