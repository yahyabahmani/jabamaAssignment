//
//  Network.swift
//  FiveSquare
//
//  Created by Shadi Ghelman on 11/24/24.
//

import Foundation

/// A class responsible for sending network requests.
public class Network {
    func sendRequest<T: Decodable>(
        param: [String: String]? = nil,
        url: URL
    ) async throws -> (data: T, nextURL: URL?) {
        // Construct URL components and add query parameters if provided
        var components = try URLComponents(url: url, resolvingAgainstBaseURL: true).unwrapped()
        
        if let param {
            components.queryItems = param.map { URLQueryItem(name: $0.key, value: $0.value) }
        }
        
        // Create a URLRequest from the components
        var request = try URLRequest(url: components.url.unwrapped())
        
        // Set default headers
        request.allHTTPHeaderFields = try [
            "Accept": "application/json",
            "Authorization": ProcessInfo.processInfo.environment["Authorization"].unwrapped()
        ]
        
        // Perform the network request
        let (data, headerResponse) = try await URLSession.shared.data(for: request)
        let httpHeaderResponse = headerResponse as? HTTPURLResponse
        let link = httpHeaderResponse?.allHeaderFields["Link"] as? String
        let nextURL = try nextPageURL(link: link)
        
        // Configure the JSON decoder
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        // Decode the response data
        let decodedData = try decoder.decode(T.self, from: data)
        return (decodedData, nextURL)
    }
    
    func nextPageURL(link: String?) throws -> URL? {
        guard let link else { return nil }
        // Regular expression pattern to extract the URL
        let pattern = #"<(https?://[^\s>]+)>"#

        let regex = try NSRegularExpression(pattern: pattern, options: [])
        let matches = regex.matches(in: link, options: [], range: NSRange(link.startIndex..., in: link))
        
        if let match = matches.first {
            // Extract the URL from the match
            if let range = Range(match.range(at: 1), in: link) {
                let extractedLink = String(link[range])
                return URL(string: extractedLink)
            }
        }
        
        return nil
    }
}
