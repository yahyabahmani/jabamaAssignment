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
    
    private(set)var isLoading:Bool = false
    
    override init() {
        super.init()
    }
    
    deinit{
    }
    
    override func onEvent(_ event: MapEvent) {
        switch event {
        case .onMarkerSelcted(let place):
            selectedPlace = place
            
        case .initializeCamera:
            self.isCameraInitialized = true
        case .changeCameraPosition(let place):
            changeCameraPosition(place)
        case .onCameraMove(let isMoving):
            moveCamera(isMoving)
        case .onFetchingData(let state):
            onFetchingData(state)
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
    
    private func onMarkerSelected(_ place:SearchPlace) {
        self.selectedPlace = place
        self.isCameraMoving = true
    }
    
    private func onFetchingData(_ state:ViewState) {
        if state == .loading {
            self.isLoading = true
        }else{
            self.isLoading = false
        }
    }
    
}
