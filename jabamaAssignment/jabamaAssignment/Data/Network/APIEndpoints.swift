//
//  APIEndpoints.swift
//  jabamaAssignment
//
//  Created by Amir  on 04/12/2024.
//

import Foundation

struct APIEndpoint {
    let url: String
    let method: HTTPMethod
    let queryItems: [URLQueryItem]?
}

enum HTTPMethod: String {
    case GET
    case POST
    case PUT
    case DELETE
}

extension APIEndpoint {
    static func searchPlaces(query: String) -> APIEndpoint {
        let url = "\(APIConfig.baseURL)/places/search"
        return APIEndpoint(
            url: url,
            method: .GET,
            queryItems: [
                URLQueryItem(name: "query", value: query)
            ]
        )
    }
}
