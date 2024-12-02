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
            .animation(.default, value: mainViewModel.places)
            .padding(.horizontal,8)
        }
        .frame(height: 200)
    }
}

#Preview {
    @Previewable @State var mainViewModel: PlaceListMainViewModel = .init()
    @Previewable @State var mapViewModel: MapViewModel = .init()
    MapPlaceListView()
        .environment(mainViewModel)
        .environment(mapViewModel)
}
