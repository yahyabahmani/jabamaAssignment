//
//  Location.swift
//  jabamaAssignment
//
//  Created by Amir  on 06/12/2024.
//

import Foundation

struct Location: Codable, Equatable, Hashable {
    let address: String?
    let formatted_address: String
    let locality: String?
    let region: String?
    let postcode: String?
    let country: String?
}
