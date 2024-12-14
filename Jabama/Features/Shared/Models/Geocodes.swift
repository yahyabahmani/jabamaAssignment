//
//  Geocodes.swift
//  Jabama
//
//  Created by Mohsen on 12/1/24.
//

import Foundation

struct Geocodes: Codable,Equatable {
    let dropOff: PlaceCoordinate?
    let frontDoor: PlaceCoordinate?
    let main: PlaceCoordinate?
    let road: PlaceCoordinate?
    let roof: PlaceCoordinate?

    enum CodingKeys: String, CodingKey {
        case dropOff = "drop_off"
        case frontDoor = "front_door"
        case main
        case road
        case roof
    }
}
