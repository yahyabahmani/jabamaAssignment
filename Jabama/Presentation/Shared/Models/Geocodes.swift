//
//  Geocodes.swift
//  Jabama
//
//  Created by Mohsen on 12/1/24.
//

import Foundation

struct Geocodes: Codable {
    let dropOff: Coordinate?
    let frontDoor: Coordinate?
    let main: Coordinate?
    let road: Coordinate?
    let roof: Coordinate?

    enum CodingKeys: String, CodingKey {
        case dropOff = "drop_off"
        case frontDoor = "front_door"
        case main
        case road
        case roof
    }
}
