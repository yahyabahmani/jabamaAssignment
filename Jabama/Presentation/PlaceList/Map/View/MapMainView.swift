//
//  MapMainView.swift
//  Jabama
//
//  Created by Mohsen on 12/2/24.
//

import SwiftUI
import MapKit

struct MapMainView: View {
    @Environment(PlaceListMainViewModel.self) var mainViewModel
    @Environment(LocationManager.self) var locationManager
    @State private var mapViewModel: MapViewModel = .init()
    
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
                
                MapStateView()
                    .environment(mainViewModel)
                    .environment(mapViewModel)
            }
        }
        .task {
            if let userLocation = locationManager.lastKnownLocation {
                cameraPosition = .region(
                    MKCoordinateRegion(
                        center: userLocation,
                        span: MKCoordinateSpan(latitudeDelta: 0.04, longitudeDelta: 0.04)
                    )
                )
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    mapViewModel.onEvent(.initializeCamera)
                }
                
            }
        }
    }
}

#Preview {
    @Previewable @State var viewModel: PlaceListMainViewModel = .init()
    @Previewable @State var locationManager: LocationManager = .init()
    MapMainView()
        .environment(viewModel)
        .environment(locationManager)
}
