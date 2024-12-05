//
//  APIConfig.swift
//  jabamaAssignment
//
//  Created by Amir  on 04/12/2024.
//

import Foundation

protocol APIConfigProtocol {
    func getValue(forKey key: String) throws -> String
    var baseURL: String { get }
    var apiToken: String { get }
}

class APIConfig: APIConfigProtocol {
    private let bundle: Bundle

    init(bundle: Bundle = .main) {
        self.bundle = bundle
    }

    func getValue(forKey key: String) throws(APIConfigError) -> String {
        if let value = bundle.object(forInfoDictionaryKey: key) as? String, !value.isEmpty {
            return value
        } else {
            throw APIConfigError.missingKey(key)
        }
    }

    var baseURL: String {
        do {
            let rawBaseURL = try getValue(forKey: "BASE_URL")
            return "https://\(rawBaseURL)"
        } catch {
            fatalError("\(error)")
        }
    }

    var apiToken: String {
        do {
            return try getValue(forKey: "API_TOKEN")
        } catch {
            fatalError("\(error)")
        }
    }
}


enum APIConfigError: Error, Equatable {
    case missingKey(String)

    var errorDescription: String? {
        switch self {
        case .missingKey(let key):
            return "Missing key: \(key) in configuration. Please ensure your .xcconfig file is correctly set up."
        }
    }
}
