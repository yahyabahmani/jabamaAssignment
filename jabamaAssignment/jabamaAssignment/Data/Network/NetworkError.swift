//
//  NetworkError.swift
//  jabamaAssignment
//
//  Created by Amir  on 04/12/2024.
//

import Foundation

enum NetworkError: LocalizedError {
    case badURL
    case serverError(statusCode: Int)
    case decodingError(error: Error)
    case noData
    case custom(message: String)
    
    var errorDescription: String? {
        switch self {
        case .badURL:
            return "The provided URL is invalid."
        case .serverError(let statusCode):
            return "Server responded with an error. Status code: \(statusCode)."
        case .decodingError(let error):
            return "Failed to decode the response. Error: \(error.localizedDescription)"
        case .noData:
            return "No data was returned from the server."
        case .custom(let message):
            return message
        }
    }
}
