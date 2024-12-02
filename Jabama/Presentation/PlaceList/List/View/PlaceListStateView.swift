//
//  PlaceListStateView.swift
//  Jabama
//
//  Created by Mohsen on 12/2/24.
//

import SwiftUI

struct PlaceListStateView: View {
    @Environment(PlaceListMainViewModel.self) var viewModel
    var body: some View {
        ZStack{
            switch viewModel.viewState {
                case .loading:
                LoadingPlaceListView()
            case .idle:
                PlaceListView()
            case .empty:
                PlaceListEmptyView()
            case .error:
                PlaceListErrorView(message: viewModel.error?.message)
            }
        }
    }
}

#Preview {
    PlaceListMainView()
}
