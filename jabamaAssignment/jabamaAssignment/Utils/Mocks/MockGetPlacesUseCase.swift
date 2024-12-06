//
//  MockPlaces.swift
//  jabamaAssignment
//
//  Created by Amir  on 06/12/2024.
//

import Foundation

final class MockGetPlacesUseCase: GetPlacesUseCaseProtocol {
    func execute(query: String) async throws(NetworkError) -> [Place] {
        return mockPlace
    }
}
