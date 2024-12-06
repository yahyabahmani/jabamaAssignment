//
//  MockPlace.swift
//  jabamaAssignment
//
//  Created by Amir  on 06/12/2024.
//

import Foundation

let mockLocation = Location(
    address: "123 Mock St",
    formatted_address: "123 Mock St, Mock City, MC 12345, USA",
    locality: "Mock City",
    region: "Mock Region",
    postcode: "12345",
    country: "USA"
)
let mockCategory = Category(
    id: 1,
    name: "Mock Category",
    short_name: "Category",
    plural_name: "Categories",
    icon: Icon(
        prefix: "https://example.com/icons/",
        suffix: "category.png"
    )
)
let mockChain = Chain(
    id: "chain-1",
    name: "Mock Chain"
)
let mockGeocodes = Geocodes(
    main: Coordinate(latitude: 37.7749, longitude: -122.4194),
    roof: Coordinate(latitude: 37.7750, longitude: -122.4200)
)
let mockPlace = [Place(
    fsq_id: "1",
    name: "Mock Place",
    location: mockLocation,
    distance: 100,
    categories: [mockCategory],
    chains: [mockChain],
    closed_bucket: "open",
    geocodes: mockGeocodes,
    link: "https://example.com/mock-place",
    timezone: "PST"
)]
