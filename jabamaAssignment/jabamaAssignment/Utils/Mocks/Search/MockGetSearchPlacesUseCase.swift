//
//  MockGetSearchPlacesUseCase.swift
//  jabamaAssignment
//
//  Created by Amir  on 07/12/2024.
//

import Foundation


final class MockGetSearchPlacesUseCase: SearchPlacesUseCaseProtocol {
    func executeNextPage() async throws -> [Place] {
        return mockPlace
    }
    
    func filterPlaces(_ places: [Place], by prefix: String) -> [Place] {
        return mockPlace
    }
    
    func execute(query: String) async throws(NetworkError) -> [Place] {
        return mockPlace
    }
}
