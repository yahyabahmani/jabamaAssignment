//
//  PlaceListMainView.swift
//  Jabama
//
//  Created by Mohsen on 12/1/24.
//

import SwiftUI

struct PlaceListMainView: View {
    @State private var viewModel: PlaceListMainViewModel = .init()
    @State private var locationManager: LocationManager = .init()
    @State private var isNoGpsPresented: Bool = false
    private var reachability: NetworkReachability = .init()
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            GeometryReader { geometry in
                let _ = geometry.size
                
                ZStack(alignment:.top){
                    SearchPlaceToolbar()
                        .environment(viewModel)
                        .zIndex(1)
                    if viewModel.viewType == .map{
                        MapMainView()
                            .environment(viewModel)
                            .environment(locationManager)
                    }else{
                        PlaceListStateView()
                            .padding(.top,60)
                            .environment(viewModel)
                    }
                    
                    if !viewModel.isLocationAvailable{
                        NoGpsView()
                            .transition(.move(edge: .leading))
                    }
                    
                    if !viewModel.isNetworkAvailable{
                        NoNetworkView{
                            if reachability.isConnected(){
                                viewModel.onEvent(.changeNetworkStatus(true))
                                viewModel.onEvent(.fetchPlaces)
                            }
                        }
                            .transition(.move(edge: .leading))
                    }
                    
                }
            }.onChange(of: locationManager.applocation){
                if let _ = locationManager.lastKnownLocation {
                    viewModel.onEvent(.onLocationChange($1))
                    locationManager.stopUpdating()
                }
                
            }
            .onChange(of: locationManager.status){
                if $1 == .authorized{
                    viewModel.onEvent(.fetchPlaces)
                    viewModel.onEvent(.changeGpsStatus(true))
                }else{
                    viewModel.onEvent(.changeGpsStatus(false))
                }
            }
        }.task {
            if !reachability.isConnected(){
                viewModel.onEvent(.changeNetworkStatus(false))
            }
        }
        
    }
}

#Preview {
    PlaceListMainView()
}
