//
//  PlaceListRepo.swift
//  Jabama
//
//  Created by Mohsen on 12/2/24.
//

import Foundation
import Combine

protocol PlaceListRepo {
    func searchPlaces(query: SearchPlaceQuery) -> AnyPublisher<SearchPlaceRes, ErrorModel>
}
