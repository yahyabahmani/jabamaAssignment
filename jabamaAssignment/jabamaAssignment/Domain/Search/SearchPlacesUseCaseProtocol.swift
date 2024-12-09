//
//  SearchPlacesUseCaseProtocol.swift
//  jabamaAssignment
//
//  Created by Amir  on 07/12/2024.
//

import Foundation

protocol SearchPlacesUseCaseProtocol {
    func execute(query: String) async throws -> [Place]
    func filterPlaces(_ places: [Place], by prefix: String) -> [Place]
    func executeNextPage() async throws -> [Place]
}
