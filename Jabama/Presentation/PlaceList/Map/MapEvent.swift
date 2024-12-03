//
//  MapEvent.swift
//  Jabama
//
//  Created by Mohsen on 12/2/24.
//

enum MapEvent {
    case onMarkerSelcted(SearchPlace)
    case initializeCamera
    case changeCameraPosition(SearchPlace)
    case onCameraMove(Bool)
}
