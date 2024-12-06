//
//  Geocodes.swift
//  jabamaAssignment
//
//  Created by Amir  on 06/12/2024.
//

import Foundation

struct Geocodes: Codable, Equatable, Hashable {
    let main: Coordinate
    let roof: Coordinate?
}
