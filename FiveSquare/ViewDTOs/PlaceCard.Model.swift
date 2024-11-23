//
//  PlaceCard.Model.swift
//  FiveSquare
//
//  Created by Shadi Ghelman on 11/23/24.
//

import Foundation

extension PlaceCard {
    struct Model: Identifiable {
        var id: String
        var imageUrl: URL?
        var name: String
        var type: String?
        var distance: Int?
    }
}

extension PlaceCard.Model {
    static func dummy() -> Self {
        let randomName = UUID().uuidString.prefix(Int.random(in: 5...15))

        return .init(
            id: UUID().uuidString,
            name: String(randomName),
            type: "Restaurant",
            distance: .random(in: 10...100)
        )
    }
}
