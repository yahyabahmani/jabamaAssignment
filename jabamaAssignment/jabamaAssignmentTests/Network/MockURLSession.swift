//
//  MockURLSession.swift
//  jabamaAssignmentTests
//
//  Created by Amir  on 05/12/2024.
//

import Foundation
@testable import jabamaAssignment

final class MockURLSession: URLSessionProtocol {
    var mockData: Data?
    var mockResponse: URLResponse?
    var mockError: Error?

    func data(for request: URLRequest) async throws -> (Data, URLResponse) {
        if let error = mockError {
            throw error
        }
        guard let data = mockData, let response = mockResponse else {
            throw NetworkError.noData
        }
        return (data, response)
    }
}

