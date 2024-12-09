//
//  URLSessionProtocol.swift
//  jabamaAssignment
//
//  Created by Amir  on 04/12/2024.
//

import Foundation
 
protocol URLSessionProtocol {
    func data(for request: URLRequest) async throws -> (Data, URLResponse)
}

extension URLSession: URLSessionProtocol {}
