//
//  PlaceListView.swift
//  Jabama
//
//  Created by Mohsen on 12/2/24.
//

import SwiftUI

struct PlaceListView: View {
    @Environment(PlaceListMainViewModel.self) var mainViewModel
    var body: some View {
        ScrollView{
            LazyVStack{
                ForEach(mainViewModel.places,id: \.id){place in
                    PlaceItemView(searchPlace: place)
                        .tag(place.id)
                }
                if mainViewModel.canLoadMore{
                    ProgressView()
                        .controlSize(.large)
                        .tint(.black)
                        .task {
                            mainViewModel.onEvent(.loadMore)
                        }
                }
            }.padding(.top)
        }
        
    }
}



#Preview {
    @Previewable @State var viewModel:PlaceListMainViewModel = .init()
    PlaceListView()
        .environment(viewModel)
}
