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
    
    func testOnLastAppear() async throws {
        // Given
        let currentPlaces = [
            Place(
                id: "1",
                geocodes: .init(main: .init(latitude: 12, longitude: 12)),
                name: "Test-1",
                distance: 12
            ),
            Place(
                id: "2",
                geocodes: .init(main: .init(latitude: 12, longitude: 12)),
                name: "Test-2",
                distance: 12
            )
        ]
        let nextPagePlaces = [
            Place(
                id: "3",
                geocodes: .init(main: .init(latitude: 12, longitude: 12)),
                name: "Test-3",
                distance: 12
            )
        ]
        
        let nextURL = URL(string: "Test")
        let expectation = XCTestExpectation(description: "Call Get Places")
        self.placesManager.places = currentPlaces
        // Assuming it already has a next url pending
        self.placesManager.nextURL = nextURL
        self.placesManager.webservice.getPlacesNextPage = { _ in
            expectation.fulfill()
            // Simulating the last page response
            return (nextPagePlaces, nil)
        }
        
        // When
        self.placesManager.onLastAppear()
        
        // Then
        await fulfillment(of: [expectation], timeout: 1)
        
        XCTAssertEqual(self.placesManager.places.count, 3)
        XCTAssertEqual(self.placesManager.places.last?.name, nextPagePlaces.last?.name)
        XCTAssertEqual(self.placesManager.nextURL, nil)
    }
}
