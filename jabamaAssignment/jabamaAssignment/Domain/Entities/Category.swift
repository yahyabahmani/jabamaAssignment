//
//  Category.swift
//  jabamaAssignment
//
//  Created by Amir  on 06/12/2024.
//

import Foundation

struct Category: Codable, Equatable, Hashable {
    let id: Int
    let name: String
    let short_name: String
    let plural_name: String
    let icon: Icon
}
