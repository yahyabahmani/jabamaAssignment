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
    
    @State private var cameraPosition: MapCameraPosition = .userLocation(fallback: .automatic)
    
    var body: some View {
        ScrollViewReader{proxy in
            ZStack(alignment:.bottom){
                Map(position:$cameraPosition){
                    
                    ForEach(mainViewModel.places,id: \.id){place in
                        Annotation("", coordinate: place.geoLocation()) {
                            CustomMarkerView(score:place.score())
                                .onTapGesture {
                                    withAnimation{
                                        proxy.scrollTo(place.id)
                                    }
                                }
                        }.tag(place.id)
                    }
                }
                
                
                ScrollView(.horizontal,showsIndicators: false){
                    LazyHStack{
                        ForEach(mainViewModel.places,id: \.id){place in
                            PlaceItemView(searchPlace: place)
                                .environment(mainViewModel)
                                .tag(place.id ?? UUID().uuidString)
                        }
                    }
                    .animation(.default, value: mainViewModel.places)
                    .padding(.horizontal)
                }
                .frame(height: 200)
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
