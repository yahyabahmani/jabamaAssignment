//
//  MapMarkerListView.swift
//  Jabama
//
//  Created by Mohsen on 12/2/24.
//

import SwiftUI
import MapKit

struct MapMarkerListView: View {
    @Binding var cameraPosition: MapCameraPosition
    @Environment(PlaceListMainViewModel.self) var mainViewModel
    @Environment(MapViewModel.self) var mapViewModel
    var extraAction:(SearchPlace)->Void = {_ in }
    
    var body: some View {
        Map(position:$cameraPosition){
            ForEach(mainViewModel.places,id: \.id){place in
                Annotation("", coordinate: place.geoLocation()) {
                    CustomMarkerView(place:place)
                        .environment(mapViewModel)
                        .onTapGesture {
                            mapViewModel.onEvent(.onPlaceSelcted(place))
                            extraAction(place)
                        }
                }.tag(place.id)
            }
        }
        .onMapCameraChange {
            if mapViewModel.isCameraInitialized {
                mainViewModel.onEvent(.onLocationChange(.init(latitude: $0.region.center.latitude, longitude: $0.region.center.longitude)))
            }
           
        }
    }
}

#Preview {
    @Previewable @State var mainViewModel: PlaceListMainViewModel = .init()
    @Previewable @State var mapViewModel: MapViewModel = .init()
    @Previewable @State var cameraPosition: MapCameraPosition = .userLocation(fallback: .automatic)
    MapMarkerListView(cameraPosition: $cameraPosition)
        .environment(mainViewModel)
        .environment(mapViewModel)
}
