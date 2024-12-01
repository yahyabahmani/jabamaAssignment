//
//  Tip.swift
//  Jabama
//
//  Created by Mohsen on 12/1/24.
//

import Foundation

struct Tip: Codable, Identifiable {
    let id: String?
    let createdAt: String?
    let text: String?
    let url: String?
    let lang: String?
    let agreeCount: Int?
    let disagreeCount: Int?

    enum CodingKeys: String, CodingKey {
        case id
        case text
        case url
        case lang
        case agreeCount = "agree_count"
        case disagreeCount = "disagree_count"
        case createdAt = "created_at"
    }
}
