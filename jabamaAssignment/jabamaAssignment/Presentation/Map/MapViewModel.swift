//
//  MapViewModel.swift
//  jabamaAssignment
//
//  Created by Amir  on 05/12/2024.
//

import Foundation
import MapKit

@MainActor
final class MapViewModel: ObservableObject {
    @Published var query: String = ""
    @Published var places: [Place] = []
    @Published var error: String? = nil
    private let getPlacesUseCase: GetPlacesUseCaseProtocol
    
    init(getPlacesUseCase: GetPlacesUseCaseProtocol) {
        self.getPlacesUseCase = getPlacesUseCase
    }
    
    func searchPlaces() async {
        do {
            places = try await getPlacesUseCase.execute(query: query)
        } catch(let error) {
            self.error = error.localizedDescription
        }
    }
}
