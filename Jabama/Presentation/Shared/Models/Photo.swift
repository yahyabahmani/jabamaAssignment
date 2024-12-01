//
//  Photo.swift
//  Jabama
//
//  Created by Mohsen on 12/1/24.
//

struct Photo: Codable, Identifiable {
    let id : String?
    let createdAt: String?
    let prefix: String?
    let suffix: String?
    let width: Int?
    let height: Int?
    let classifications: [String]?
    let tip: Tip?

    enum CodingKeys: String, CodingKey {
        case id
        case prefix
        case suffix
        case width
        case height
        case classifications
        case tip
        case createdAt = "created_at"
    }
}
