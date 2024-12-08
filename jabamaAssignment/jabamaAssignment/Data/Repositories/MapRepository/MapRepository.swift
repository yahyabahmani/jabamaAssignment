//
//  MapRepository.swift
//  jabamaAssignment
//
//  Created by Amir  on 05/12/2024.
//

import Foundation

final class MapRepository: MapRepositoryProtocol, Paginatable {
    private let networkManager: NetworkManagerProtocol
    private let apiConfig: APIConfigProtocol
    private var nextPageURL: String?
    
    init(networkManager: NetworkManagerProtocol, apiConfig: APIConfigProtocol = APIConfig()) {
        self.networkManager = networkManager
        self.apiConfig = apiConfig
    }
    
    func getPlaces(query: String) async throws -> [Place] {
        let urlString = nextPageURL.flatMap { parseNextPageURL(from: $0) } ?? "\(apiConfig.baseURL)/places/search"
        guard var components = URLComponents(string: urlString) else {
            throw NetworkError.badURL
        }
        if nextPageURL == nil {
            components.queryItems = [URLQueryItem(name: "query", value: query)]
        }
        guard let url = components.url else {
            throw NetworkError.badURL
        }
        let endpoint = APIEndpoint(url: url.absoluteString, method: .GET)
        let (response, nextPage) = try await networkManager.fetchData(endpoint: endpoint, responseModel: PlacesResponse.self)
        nextPageURL = nextPage
        return response.results
    }

    func resetPagination() {
        nextPageURL = nil
    }
}

