//
//  MapStateView.swift
//  Jabama
//
//  Created by Mohsen on 12/2/24.
//

import SwiftUI

struct MapStateView: View {
    @Environment(PlaceListMainViewModel.self) var mainViewModel
    @Environment(MapViewModel.self) var mapViewModel
    var body: some View {
        if mainViewModel.placeListState == .loading {
            MapLoadingView()
        }else if mainViewModel.placeListState == .idle{
            MapPlaceListView()
                .environment(mainViewModel)
                .environment(mapViewModel)
        }else{
            ZStack{}
        }
    }
}

#Preview {
    @Previewable @State var viewModel: PlaceListMainViewModel = .init()
    @Previewable @State var mapViewModel: MapViewModel = .init()
    MapStateView()
        .environment(viewModel)
        .environment(mapViewModel)
}
