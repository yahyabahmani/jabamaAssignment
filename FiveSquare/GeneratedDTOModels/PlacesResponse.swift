//
//  DTO.swift
//  FiveSquare
//
//  Created by Shadi Ghelman on 11/24/24.
//

import Foundation

public struct PlacesResponse: Decodable {
    public let results: [Place]
    public let context: Context
}

public struct Context: Decodable {
    public let geoBounds: GeoBounds?
}

public struct GeoBounds: Decodable {
    public let circle: Circle
}

public struct Circle: Decodable {
    public let center: Center
    public let radius: Int
}

public struct Place: Decodable {
    public var fsqId: String
    public var geocodes: Geocodes
    public var name: String
    public var categories: [Category]?
    public var photos: [Photo]?
    public var distance: Int?

    init(id: String, geocodes: Geocodes, name: String, categories: [Category]? = nil , photos: [Photo]? = nil, distance: Int) {
        self.fsqId = id
        self.geocodes = geocodes
        self.name = name
        self.categories = categories
        self.distance = distance
    }
}

public struct Geocodes: Decodable {
    public let main: Center
    public var roof: Center? = nil
}

public struct Center: Decodable {
    public let latitude, longitude: Double
}

public struct Category: Decodable {
    public let id: Int
    public let name, shortName, pluralName: String
    let icon: Icon
}

public struct Photo: Decodable {
    let prefix: String?
    let suffix: String
}

struct Icon: Decodable {
    let prefix: String?
    let suffix: String
}
