//
//  Category.swift
//  Jabama
//
//  Created by Mohsen on 12/1/24.
//

import Foundation

struct Category: Codable, Identifiable {
    let id: Int?
    let name: String?
    let shortName: String?
    let pluralName: String?
    let icon: Photo?

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case shortName = "short_name"
        case pluralName = "plural_name"
        case icon
    }
}
