//
//  APIConfig.swift
//  jabamaAssignment
//
//  Created by Amir  on 04/12/2024.
//

import Foundation

enum APIConfigError: Error {
    case missingKey(String)
    
    var description: String {
        switch self {
        case .missingKey(let key):
            return "Missing key: \(key) in configuration. Please ensure your .xcconfig file is correctly set up."
        }
    }
}

struct APIConfig {
    static func getValue(forKey key: String) throws -> String {
        if let value = Bundle.main.object(forInfoDictionaryKey: key) as? String, !value.isEmpty {
            return value
        } else {
            throw APIConfigError.missingKey(key)
        }
    }
    
    static var baseURL: String {
            do {
                let rawBaseURL = try getValue(forKey: "BASE_URL")
                    return "https://\(rawBaseURL)"
            } catch {
                fatalError("\(error)")
            }
        }
    
    static var apiToken: String {
        do {
            return try getValue(forKey: "API_TOKEN")
        } catch {
            fatalError("\(error)")
        }
    }
}
