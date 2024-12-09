//
//  MockPlaces.swift
//  jabamaAssignment
//
//  Created by Amir  on 06/12/2024.
//

import Foundation

final class MockGetPlacesUseCase: GetPlacesUseCaseProtocol {
    func filterPlaces(_ places: [Place], by prefix: String) -> [Place] {
        return mockPlace
    }
    
    func executeNextPage() async throws -> [Place] {
        return mockPlace
    }
    
    func resetSearch() {
        
    }
    
    func execute(query: String) async throws(NetworkError) -> [Place] {
        return mockPlace
    }
}
