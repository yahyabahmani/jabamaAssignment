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
        GeometryReader { geometry in
            let _ = geometry.size
            
            ZStack(alignment:.top){
                SearchPlaceToolbar()
                    .environment(viewModel)
                PlaceListView()
                    .padding(.top,60)
                    .environment(viewModel)
            }
        }
    }
}

#Preview {
    PlaceListMainView()
}
