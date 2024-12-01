//
//  Context.swift
//  Jabama
//
//  Created by Mohsen on 12/1/24.
//

import Foundation

struct Context: Codable {
    let geoBounds: GeoBounds?

    enum CodingKeys: String, CodingKey {
        case geoBounds = "geo_bounds"
    }
}
