//
//  Hours.swift
//  Jabama
//
//  Created by Mohsen on 12/1/24.
//

import Foundation

struct Hours: Codable {
    let display: String?
    let isLocalHoliday: Bool?
    let openNow: Bool?
    let regular: [RegularHour]?

    enum CodingKeys: String, CodingKey {
        case display
        case isLocalHoliday = "is_local_holiday"
        case openNow = "open_now"
        case regular
    }
}
