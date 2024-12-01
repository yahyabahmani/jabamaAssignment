//
//  ErrorModel.swift
//  Ludo
//
//  Created by mohsen mokhtari on 9/14/23.
//

import Foundation

struct ErrorModel: Codable,Error,Equatable {
    var code: Int?
    var message: String?
}
