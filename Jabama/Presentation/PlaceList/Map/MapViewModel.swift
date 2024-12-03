//
//  MapViewModel.swift
//  Jabama
//
//  Created by Mohsen on 12/2/24.
//

import Foundation

@Observable
class MapViewModel:BaseViewModel<MapEvent> {
    
    private(set) var selectedPlace:SearchPlace?
    private(set) var isCameraInitialized:Bool = false
    
    override func onEvent(_ event: MapEvent) {
        switch event {
        case .onPlaceSelcted(let place):
            selectedPlace = place
        case .initializeCamera:
            self.isCameraInitialized = true
        }
    }
    
}
