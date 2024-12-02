//
//  PlaceListMapViewModel.swift
//  Jabama
//
//  Created by Mohsen on 12/2/24.
//

import Foundation

@Observable
class PlaceListMapViewModel:BaseViewModel<PlaceListMapEvent> {
    
    private(set) var selectedPlace:SearchPlace?
    
    override func onEvent(_ event: PlaceListMapEvent) {
        switch event {
        case .onPlaceSelcted(let place):
            selectedPlace = place
        }
    }
    
}
