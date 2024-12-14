//
//  PlaceListApiService.swift
//  Jabama
//
//  Created by Mohsen on 12/2/24.
//

import Foundation
import Combine

struct PlaceListApiService {
    @Inject private var repo: PlaceListRepo
    
    func searchPlaces(query: SearchPlaceQuery) -> AnyPublisher<SearchPlaceRes, ErrorModel> {
        return repo.searchPlaces(query: query)
    }
}
