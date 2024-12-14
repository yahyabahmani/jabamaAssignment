//
//  Stats.swift
//  Jabama
//
//  Created by Mohsen on 12/1/24.
//

import Foundation

struct Stats: Codable {
    let totalPhotos: Int?
    let totalRatings: Int?
    let totalTips: Int?

    enum CodingKeys: String, CodingKey {
        case totalPhotos = "total_photos"
        case totalRatings = "total_ratings"
        case totalTips = "total_tips"
    }
}
