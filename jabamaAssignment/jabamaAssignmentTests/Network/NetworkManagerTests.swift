//
//  NetworkManagerTests.swift
//  jabamaAssignmentTests
//
//  Created by Amir  on 05/12/2024.
//

import XCTest
@testable import jabamaAssignment

final class NetworkManagerTests: XCTestCase {
    private var mockSession: MockURLSession!
    private var mockAPIConfig: MockAPIConfig!
    private var networkManager: NetworkManager!
    
    private var commonEndpoint: APIEndpoint {
        APIEndpoint(
            url: "https://mock.api.example.com/endpoint",
            method: .GET,
            queryItems: [URLQueryItem(name: "query", value: "Test")]
        )
    }
    
    override func setUp() {
        super.setUp()
        mockSession = MockURLSession()
        mockAPIConfig = MockAPIConfig()
        networkManager = NetworkManager(session: mockSession, apiConfig: mockAPIConfig)
    }
    
    override func tearDown() {
        mockSession = nil
        mockAPIConfig = nil
        networkManager = nil
        super.tearDown()
    }
    
    func testFetchDataSuccess() async throws {
        // Arrange
        let expectedResponse = MyModel(key: "value")
        let jsonData = try JSONEncoder().encode(expectedResponse)
        mockSession.mockData = jsonData
        mockSession.mockResponse = HTTPURLResponse(
            url: URL(string: commonEndpoint.url)!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )

        // Act
        let response: MyModel = try await networkManager.fetchData(endpoint: commonEndpoint, responseModel: MyModel.self)

        // Assert
        XCTAssertEqual(response.key, "value")
    }
    
    func testFetchDataServerError() async {
        // Arrange
        mockSession.mockResponse = HTTPURLResponse(
            url: URL(string: commonEndpoint.url)!,
            statusCode: 500, // Simulate a server error
            httpVersion: nil,
            headerFields: nil
        )
        mockSession.mockData = Data()

        // Act & Assert
        do {
            _ = try await networkManager.fetchData(endpoint: commonEndpoint, responseModel: MyModel.self)
            XCTFail("Expected to throw, but did not throw.")
        } catch NetworkError.serverError(let statusCode) {
            XCTAssertEqual(statusCode, 500) // Validate the status code
        } catch {
            XCTFail("Unexpected error type: \(error)")
        }
    }
    
    func testFetchDataDecodingError() async {
        // Arrange
        mockSession.mockData = Data("invalid json".utf8)
        mockSession.mockResponse = HTTPURLResponse(
            url: URL(string: commonEndpoint.url)!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )

        // Act & Assert
        do {
            _ = try await networkManager.fetchData(endpoint: commonEndpoint, responseModel: MyModel.self)
            XCTFail("Expected to throw, but did not throw.")
        } catch NetworkError.decodingError {
            // Success: The correct error was thrown
        } catch {
            XCTFail("Unexpected error type: \(error)")
        }
    }
    
    func testFetchDataInvalidResponse() async {
        // Arrange
        mockSession.mockResponse = URLResponse(
            url: URL(string: commonEndpoint.url)!,
            mimeType: nil,
            expectedContentLength: 0,
            textEncodingName: nil
        )
        mockSession.mockData = Data()

        // Act & Assert
        do {
            _ = try await networkManager.fetchData(endpoint: commonEndpoint, responseModel: MyModel.self)
            XCTFail("Expected to throw, but did not throw.")
        } catch NetworkError.custom(let message) {
            XCTAssertTrue(message.contains("Invalid response received"), "Expected custom error with 'Invalid response received'")
        } catch {
            XCTFail("Unexpected error type: \(error)")
        }
    }
    
    func testFetchDataCustomError() async {
        // Arrange
        mockSession.mockError = URLError(.notConnectedToInternet) // Simulate a generic network error

        // Act & Assert
        do {
            _ = try await networkManager.fetchData(endpoint: commonEndpoint, responseModel: MyModel.self)
            XCTFail("Expected to throw, but did not throw.")
        } catch NetworkError.custom(let message) {
            XCTAssertTrue(message.contains("The operation couldn’t be completed."))
        } catch {
            XCTFail("Unexpected error type: \(error)")
        }
    }
    
    func testFetchDataBadURL() async {
        // Arrange
        let endpoint = APIEndpoint(
            url: "ht*tp://invalid-url", // Invalid URL
            method: .GET,
            queryItems: nil
        )

        // Act & Assert
        do {
            _ = try await networkManager.fetchData(endpoint: endpoint, responseModel: MyModel.self)
            XCTFail("Expected to throw, but did not throw.")
        } catch NetworkError.badURL {
            // Success: The correct error was thrown
        } catch {
            XCTFail("Unexpected error type: \(error)")
        }
    }
}

struct MyModel: Codable, Equatable {
    let key: String
}
