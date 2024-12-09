//
//  Paginatable.swift
//  jabamaAssignment
//
//  Created by Amir  on 08/12/2024.
//

import Foundation

protocol Paginatable {
    func parseNextPageURL(from linkHeader: String) -> String?
}

extension Paginatable {
    func parseNextPageURL(from linkHeader: String) -> String? {
        guard let range = linkHeader.range(of: "<(.*?)>", options: .regularExpression) else { return nil }
        return String(linkHeader[range])
            .trimmingCharacters(in: CharacterSet(charactersIn: "<>"))
    }
}
