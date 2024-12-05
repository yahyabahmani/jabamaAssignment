//
//  MockBundle.swift
//  jabamaAssignmentTests
//
//  Created by Amir  on 05/12/2024.
//

import Foundation

final class MockBundle: Bundle, @unchecked Sendable {
    private let mockInfoDictionary: [String: Any]

    init(infoDictionary: [String: Any]) {
        self.mockInfoDictionary = infoDictionary
        super.init()
    }

    override func object(forInfoDictionaryKey key: String) -> Any? {
        return mockInfoDictionary[key]
    }
}
