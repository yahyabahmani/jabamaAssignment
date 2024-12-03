//
//  MapPlaceListView.swift
//  Jabama
//
//  Created by Mohsen on 12/2/24.
//

import SwiftUI

struct MapPlaceListView: View {
    @Environment(PlaceListMainViewModel.self) var mainViewModel
    @Environment(MapViewModel.self) var mapViewModel
    var body: some View {
        ScrollView(.horizontal,showsIndicators: false){
            LazyHStack(spacing:12){
                ForEach(mainViewModel.places,id: \.id){place in
                    PlaceItemView(searchPlace: place)
                        .environment(mainViewModel)
                        .tag(place.id ?? UUID().uuidString)
                        .scrollTransition(.interactive, axis: .horizontal) { effect, phase in
                            effect.scaleEffect(phase.isIdentity ? 1.0 : 0.95)
                        }
                        .onAppear {
                            markerAction(place)
                        }
                        .onTapGesture {
                            mapViewModel.onEvent(.onCameraMove(false))
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                markerAction(place)
                            }
                        }
                    
                }
                
                if mainViewModel.canLoadMore{
                    ProgressView()
                        .controlSize(.large)
                        .tint(.black)
                        .task {
                            mainViewModel.onEvent(.loadMore)
                        }
                }
            }
            .scrollTargetLayout()
            .animation(.default, value: mainViewModel.places)
            .padding(.horizontal,8)
        }
        .scrollTargetBehavior(.viewAligned)
        .frame(height: 200)
    }
    
    private func markerAction(_ place:SearchPlace){
        if !mapViewModel.isCameraMoving && !mapViewModel.isLoading{
            withAnimation{
                mapViewModel.onEvent(.changeCameraPosition(place))
            }
        }
    }
}

#Preview {
    @Previewable @State var mainViewModel: PlaceListMainViewModel = .init()
    @Previewable @State var mapViewModel: MapViewModel = .init()
    MapPlaceListView()
        .environment(mainViewModel)
        .environment(mapViewModel)
}
