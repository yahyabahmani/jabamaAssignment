//
//  NetworkManager.swift
//  jabamaAssignment
//
//  Created by Amir  on 04/12/2024.
//

import Foundation

protocol NetworkManagerProtocol {
    func fetchData<T: Decodable>(
        endpoint: APIEndpoint,
        responseModel: T.Type
    ) async throws(NetworkError) -> (data: T, nextPageURL: String?)
}

final class NetworkManager: NetworkManagerProtocol {
    private let session: URLSessionProtocol
    private let apiConfig: APIConfigProtocol
    
    init(session: URLSessionProtocol = URLSession.shared, apiConfig: APIConfigProtocol = APIConfig()) {
         self.session = session
         self.apiConfig = apiConfig
     }
    
    private var defaultHeaders: [String: String] {
        [
            "accept": "application/json",
            "Authorization": apiConfig.apiToken
        ]
    }
    
    func fetchData<T: Decodable>(
        endpoint: APIEndpoint,
        responseModel: T.Type
    ) async throws(NetworkError) -> (data: T, nextPageURL: String?) {
        guard let url = URL(string: endpoint.url) else {
            throw NetworkError.badURL
        }
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.timeoutInterval = 10
        
        for (key, value) in defaultHeaders {
            request.setValue(value, forHTTPHeaderField: key)
        }
        
        do {
            let (data, response) = try await session.data(for: request)

            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkError.custom(message: "Invalid response received")
            }

            guard (200...299).contains(httpResponse.statusCode) else {
                throw NetworkError.serverError(statusCode: httpResponse.statusCode)
            }

            let nextPageURL = httpResponse.value(forHTTPHeaderField: "link")

            do {
                let decodedResponse = try JSONDecoder().decode(T.self, from: data)
                return (decodedResponse, nextPageURL)
            } catch {
                throw NetworkError.decodingError(error: error)
            }

        } catch let error as NetworkError {
            throw error
        } catch {
            throw NetworkError.custom(message: error.localizedDescription)
        }
    }
}
