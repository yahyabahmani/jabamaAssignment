//
//  URLComponentsExt.swift
//  Boom
//
//  Created by Mohsen Mokhtari on 6/15/20.
//

import Foundation

extension URLComponents {
    
    mutating func setQueryItems(with parameters: [String: Any]) {
        self.queryItems = parameters.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
    }
}
