//
//  SearchRepository.swift
//  jabamaAssignment
//
//  Created by Amir  on 07/12/2024.
//

import Foundation

final class SearchRepository: MapRepositoryProtocol {
    private let networkManager: NetworkManagerProtocol
    private let apiConfig: APIConfigProtocol
    
    init(networkManager: NetworkManagerProtocol, apiConfig: APIConfigProtocol = APIConfig()) {
        self.networkManager = networkManager
        self.apiConfig = apiConfig
    }
    
    func getPlaces(query: String) async throws(NetworkError) -> [Place] {
        let endpoint = APIEndpoint(
            url: "\(apiConfig.baseURL)/places/search",
            method: .GET,
            queryItems: [URLQueryItem(name: "query", value: query)]
        )
        return try await networkManager.fetchData(endpoint: endpoint, responseModel: PlacesResponse.self).results
    }
}
