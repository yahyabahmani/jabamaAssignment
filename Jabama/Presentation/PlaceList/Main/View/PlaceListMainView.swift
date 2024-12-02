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
                    
                }
            }.onChange(of: locationManager.applocation){
                viewModel.onEvent(.onLocationChange($1))
            }
            .onChange(of: locationManager.status){
                if $1 == .authorized{
                    viewModel.onEvent(.fetchPlaces)
                }
            }
        }
        
    }
}

#Preview {
    PlaceListMainView()
}
