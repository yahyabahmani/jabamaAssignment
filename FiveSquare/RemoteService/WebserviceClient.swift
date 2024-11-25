//
//  WebserviceClient.swift
//  FiveSquare
//
//  Created by Shadi Ghelman on 11/24/24.
//

import Foundation

struct WebserviceClient {
    /// A closure that fetches a list of places asynchronously.
    var getPlaces: (_ coordinate: String?, _ radius: Int?, _ query: String?) async throws -> (data: [Place], nextURL: URL?) = { _, _, _ in
        throw DependencyError.unimplemented
    }

    /// A closure that fetches the next page of the places asynchronously.
    var getPlacesNextPage: (URL) async throws -> (data: [Place], nextURL: URL?) = { _ in
        throw DependencyError.unimplemented
    }

    /// Internal errors
    enum DependencyError: Error {
        case unimplemented
    }
}

// MARK: - Convenience functions

/// Convenience methods to allow the caller see the parameter labels
extension WebserviceClient {
    /// A closure that fetches a list of movies asynchronously.
    func getPlaces(coordinate: String?, radius: Int?, query: String?) async throws -> (data: [Place], nextURL: URL?) {
        try await getPlaces(coordinate, radius, query)
    }
}

extension WebserviceClient {
    /// A live instance of the `WebserviceClient`, which interacts with the real API via `Foursquare`.
    static var live: Self {
        WebserviceClient(
            getPlaces: { coordinate, radius, query in
                let response: PlacesResponse
                let nextURL: URL?
                (response, nextURL) = try await FoursquareAPI.shared.getPlaces(
                    coordinate: coordinate,
                    radius: radius,
                    query: query
                )
                return (response.results, nextURL)
            },
            getPlacesNextPage: { url in
                let response: PlacesResponse
                let nextURL: URL?
                (response, nextURL) = try await FoursquareAPI.shared.getPlacesNextPage(url)

                return (response.results, nextURL)
            }
        )
    }

    /// A dummy instance of the `WebserviceClient`, useful for testing.
    /// Simulates a delay and returns dummy data.
    static var dummy: Self {
        WebserviceClient(
            getPlaces: { _, _, _ in
                // Simulates a 2-second delay.
                try await Task.sleep(for: .seconds(2))
                return (dummyPlaces(), URL(string: "dummy"))
            },
            getPlacesNextPage: { _ in
                // Simulates a 2-second delay.
                try await Task.sleep(for: .seconds(2))
                return (dummyPlaces(), URL(string: "dummy"))
            }
        )
    }

    private static func dummyPlaces() -> [Place] {
        (1...10).map {
            let randomName = UUID().uuidString.prefix(Int.random(in: 5...15))

            return .init(
                id: "\($0)" + randomName,
                geocodes: Geocodes(main: .init(
                    latitude: .random(in: 25...40),
                    longitude: .random(in: 48...60)
                )),
                name: String(randomName),
                distance: $0 * 10
            )
        }
    }
}
