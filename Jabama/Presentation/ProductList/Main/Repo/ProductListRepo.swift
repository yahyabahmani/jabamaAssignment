//
//  ProductListRepo.swift
//  Jabama
//
//  Created by Mohsen on 12/2/24.
//

import Foundation
import Combine

protocol ProductListRepo {
    func searchPlaces(query: SearchPlaceQuery) -> AnyPublisher<SearchPlaceRes, ErrorModel>
}
