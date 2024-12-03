//
//  MapViewModel.swift
//  Jabama
//
//  Created by Mohsen on 12/2/24.
//

import Foundation
import Combine

@Observable
class MapViewModel:BaseViewModel<MapEvent> {
    
    private(set) var selectedPlace:SearchPlace?
    private(set) var isCameraInitialized:Bool = false
    private(set) var currentCameraLocation:AppLocation = .init()
    private(set) var isCameraMoving:Bool = false
    
    @ObservationIgnored
    var cancellables = Set<AnyCancellable>()
    
    override init() {
        super.init()
    }
    
    deinit{
        cancellables.removeAll()
    }
    
    override func onEvent(_ event: MapEvent) {
        switch event {
        case .onPlaceSelcted(let place):
            selectedPlace = place
        case .initializeCamera:
            self.isCameraInitialized = true
        case .changeCameraPosition(let place):
            changeCameraPosition(place)
        case .onCameraMove(let isMoving):
            moveCamera(isMoving)
        }
    }
    
}

extension MapViewModel {
    private func changeCameraPosition(_ place:SearchPlace) {
        self.currentCameraLocation = .init(latitude: place.geocodes?.main?.latitude, longitude: place.geocodes?.main?.longitude)
        self.selectedPlace = place
        self.isCameraInitialized = false
        
    }
    
    private func moveCamera(_ isMoving:Bool) {
        isCameraMoving = isMoving
    }
    
}
