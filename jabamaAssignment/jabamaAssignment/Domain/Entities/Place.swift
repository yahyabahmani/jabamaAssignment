//
//  Place.swift
//  jabamaAssignment
//
//  Created by Amir  on 06/12/2024.
//

import Foundation

struct Place: Codable, Identifiable, Equatable, Hashable {
    let fsq_id: String
    let name: String
    let location: Location
    let distance: Int?
    let categories: [Category]
    let chains: [Chain]
    let closed_bucket: String
    let geocodes: Geocodes
    let link: String
    let timezone: String
    
    // Conforming to `Identifiable` using `fsq_id`
    var id: String { fsq_id }
}
