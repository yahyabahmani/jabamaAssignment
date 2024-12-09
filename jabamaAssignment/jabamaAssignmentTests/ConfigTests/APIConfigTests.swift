//
//  APIConfigTests.swift
//  jabamaAssignmentTests
//
//  Created by Amir  on 05/12/2024.
//

import XCTest
@testable import jabamaAssignment

final class APIConfigTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Mock your test environment if needed
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testGetValueForKeyWithValidKey() {
        // Arrange
        let mockBundle = MockBundle(infoDictionary: [
            "BASE_URL": "api.foursquare.com/v3",
            "API_TOKEN": "test-token"
        ])
        let apiConfig = APIConfig(bundle: mockBundle)
        
        // Act
        let baseURL = try? apiConfig.getValue(forKey: "BASE_URL")
        let apiToken = try? apiConfig.getValue(forKey: "API_TOKEN")
        
        // Assert
        XCTAssertEqual(baseURL, "api.foursquare.com/v3")
        XCTAssertEqual(apiToken, "test-token")
    }
    
    func testGetValueForKeyWithInvalidKey() {
        // Arrange
        let mockBundle = MockBundle(infoDictionary: [:])
        let apiConfig = APIConfig(bundle: mockBundle)
        
        // Act & Assert
        XCTAssertThrowsError(try apiConfig.getValue(forKey: "MISSING_KEY")) { error in
            XCTAssertEqual(error as? APIConfigError, .missingKey("MISSING_KEY"))
        }
    }
}
