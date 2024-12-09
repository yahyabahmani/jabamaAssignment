//
//  MockAPIConfig.swift
//  jabamaAssignmentTests
//
//  Created by Amir  on 05/12/2024.
//

import Foundation
@testable import jabamaAssignment

final class MockAPIConfig: APIConfigProtocol {
    func getValue(forKey key: String) throws -> String {
        switch key {
        case "BASE_URL":
            return "https://mock.api.example.com"
        case "API_TOKEN":
            return "mock-token"
        default:
            throw APIConfigError.missingKey(key)
        }
    }

    var baseURL: String {
        return "https://mock.api.example.com"
    }

    var apiToken: String {
        return "mock-token"
    }
}
