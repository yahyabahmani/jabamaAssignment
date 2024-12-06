//
//  PlacesResponse.swift
//  jabamaAssignment
//
//  Created by Amir  on 05/12/2024.
//

import Foundation


struct PlacesResponse: Codable, Equatable, Hashable {
    let results: [Place]
    let context: Context
}
