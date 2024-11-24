//
//  FiveSquareTests.swift
//  FiveSquareTests
//
//  Created by Shadi Ghelman on 11/24/24.
//

@testable import FiveSquare
import XCTest

final class FiveSquareTests: XCTestCase {
    var placesManager: PlaceManager!

    override func setUp() {
        super.setUp()
        self.placesManager = PlaceManager()
    }
    
    override func tearDown() {
        self.placesManager = nil
        super.tearDown()
    }
    
    func testOnSearchTap() async throws {
        // Given
        let currentPlaces = [
            Place(
                id: "1",
                geocodes: .init(main: .init(latitude: 1, longitude: 1)),
                name: "Test-1",
                distance: 12
            ),
            Place(
                id: "2",
                geocodes: .init(main: .init(latitude: 2, longitude: 2)),
                name: "Test-2",
                distance: 12
            )
        ]
        
        let expectedNextUrl = URL(string: "TEST")
        let expectation = XCTestExpectation(description: "Call Get Places")
        self.placesManager.webservice.getPlaces = { _, _, _ in
            expectation.fulfill()
            return (currentPlaces, expectedNextUrl)
        }
        
        // When
        self.placesManager.onSearchTap(
            coordinate: .init(latitude: 13, longitude: 13),
            distance: 10,
            text: ""
        )
        
        // Then
        
        await fulfillment(of: [expectation], timeout: 1)
        
        XCTAssertEqual(self.placesManager.places.count, currentPlaces.count)
        XCTAssertEqual(self.placesManager.places.first?.name, "Test-1")
        XCTAssertEqual(self.placesManager.nextURL, expectedNextUrl)
    }
}
