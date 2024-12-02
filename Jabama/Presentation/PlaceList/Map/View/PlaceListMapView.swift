//
//  PlaceListMapView.swift
//  Jabama
//
//  Created by Mohsen on 12/2/24.
//

import SwiftUI
import MapKit

struct PlaceListMapView: View {
    @Environment(PlaceListMainViewModel.self) var mainViewModel
    @Environment(LocationManager.self) var locationManager
    @State private var mapViewModel: PlaceListMapViewModel = .init()
    
    @State private var cameraPosition: MapCameraPosition = .userLocation(fallback: .automatic)
    
    var body: some View {
        ScrollViewReader{proxy in
            ZStack(alignment:.bottom){

                MapMarkerListView(cameraPosition:$cameraPosition){ place in
                    withAnimation{
                        proxy.scrollTo(place.id)
                    }
                }
                .environment(mainViewModel)
                .environment(mapViewModel)
                
                MapPlaceListView()
                    .environment(mainViewModel)
                    .environment(mapViewModel)
            }
        }
        .task {
            if let userLocation = locationManager.lastKnownLocation {
                cameraPosition = .region(
                    MKCoordinateRegion(
                        center: userLocation,
                        span: MKCoordinateSpan(latitudeDelta: 0.09, longitudeDelta: 0.09)
                    )
                )
            }
        }
    }
}

#Preview {
    @Previewable @State var viewModel: PlaceListMainViewModel = .init()
    @Previewable @State var locationManager: LocationManager = .init()
    PlaceListMapView()
        .environment(viewModel)
        .environment(locationManager)
}
