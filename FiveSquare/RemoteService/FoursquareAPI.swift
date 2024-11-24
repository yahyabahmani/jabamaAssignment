//
//  Webservice.live.swift
//  FiveSquare
//
//  Created by Shadi Ghelman on 11/24/24.
//

import Foundation

struct FoursquareAPI {
    static let shared = FoursquareAPI()
    
    private let network = Network()
    
    func getPlaces(coordinate: String?, radius: Int?, query: String?) async throws -> (data: PlacesResponse, nextURL: URL?) {
        let endpoint = try URL(string: BaseURL.search).unwrapped()
        
        // Convert struct into URL query items, headers, or body, as needed
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        // Create parameters using the structured model
        let params = SearchParams(
            coordinate: coordinate,
            radius: { if let radius { "\(radius)" } else { nil }}(),
            query: query
        )
        let encodedParams = try encoder.encode(params)
        // Convert encoded params into a dictionary to pass as query
        let rawDictionaryParams = try JSONSerialization.jsonObject(with: encodedParams)
        // Verify and validate the types
        let dictionaryParams = try (rawDictionaryParams as? [String: String]).unwrapped()
        
        return try await network.sendRequest(param: dictionaryParams, url: endpoint)
    }
    
    func getPlacesNextPage(_ url: URL) async throws -> (data: PlacesResponse, nextURL: URL?) {
        try await network.sendRequest(url: url)
    }
}

extension FoursquareAPI {
    struct SearchParams: Codable {
        var coordinate: String?
        var radius: String?
        var query: String?
        
        enum CodingKeys: String, CodingKey {
            case coordinate = "ll"
            case radius
            case query
        }
    }
}

public enum BaseURL {
    static let baseUrl = "https://api.foursquare.com/v3/places"
    
    static var search: String { baseUrl + "/search" }
}
