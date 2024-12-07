//
//  MapRepositoryProtocol.swift
//  jabamaAssignment
//
//  Created by Amir  on 05/12/2024.
//

import Foundation

protocol MapRepositoryProtocol {
    func getPlaces(query: String) async throws(NetworkError) -> [Place]
}
