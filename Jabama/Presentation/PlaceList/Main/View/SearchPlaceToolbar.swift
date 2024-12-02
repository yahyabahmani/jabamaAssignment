//
//  SearchPlaceToolbar.swift
//  Jabama
//
//  Created by Mohsen on 12/1/24.
//

import SwiftUI

struct SearchPlaceToolbar: View {
    @Environment(PlaceListMainViewModel.self) var viewModel
    @State var searchText: String = ""
    var body: some View {
        ZStack{
            HStack(spacing:16){
                HStack{
                    Image(systemName: "magnifyingglass")
                        .foregroundStyle(.black)
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    TextField("Search", text: $searchText.onChange({value in
                        viewModel.onEvent(.onSearchTextChanged(value))
                    }))
                    .font(.body)
                    .textFieldStyle(.plain)
                    .padding(.vertical,4)
                    .foregroundStyle(.black)
                    
                        
                }
                .padding(4)
                .frame(maxWidth: .infinity)
                .background(.white)
                .cornerRadius(8)
                
                Button{
                    viewModel.onEvent(.changeViewType)
                }label: {
                        Image(systemName: viewModel.viewType.image)
                            .foregroundColor(.white)
                            .font(.title)
                            .fontWeight(.semibold)
                            .contentTransition(.symbolEffect(.replace, options: .nonRepeating))
                            .frame(width: 30, height: 30)
                }
            }
            .padding(.horizontal,24)
            .padding(.vertical)
        }
        .frame(height:60)
        .background(.kAccent)
    }
}

#Preview {
    @Previewable @State var viewModel: PlaceListMainViewModel = .init()
    VStack {
        SearchPlaceToolbar()
            .environment(viewModel)
        
        Spacer()
    }
}
