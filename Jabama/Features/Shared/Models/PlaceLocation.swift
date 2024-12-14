//
//  PlaceLocation.swift
//  Jabama
//
//  Created by Mohsen on 12/1/24.
//

import Foundation

struct PlaceLocation: Codable,Equatable {
    let address: String?
    let addressExtended: String?
    let adminRegion: String?
    let censusBlock: String?
    let country: String?
    let crossStreet: String?
    let dma: String?
    let formattedAddress: String?
    let locality: String?
    let neighborhood: [String]?
    let poBox: String?
    let postTown: String?
    let postcode: String?
    let region: String?

    enum CodingKeys: String, CodingKey {
        case address
        case addressExtended = "address_extended"
        case adminRegion = "admin_region"
        case censusBlock = "census_block"
        case country
        case crossStreet = "cross_street"
        case dma
        case formattedAddress = "formatted_address"
        case locality
        case neighborhood
        case poBox = "po_box"
        case postTown = "post_town"
        case postcode
        case region
    }
}
