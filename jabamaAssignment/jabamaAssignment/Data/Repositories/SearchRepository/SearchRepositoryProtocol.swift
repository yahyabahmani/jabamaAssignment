//
//  SearchRepositoryProtocol.swift
//  jabamaAssignment
//
//  Created by Amir  on 07/12/2024.
//

import Foundation

protocol SearchRepositoryProtocol {
    func getPlaces(query: String) async throws -> [Place]
}

