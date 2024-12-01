//
//  ApiResponse.swift
//  Ludo
//
//  Created by Mohsen on 7/12/24.
//

import Foundation
struct ApiResponse<T:Codable>:Codable{
    let data:T?
    let meta:Meta?
    let error:ErrorModel?
}
