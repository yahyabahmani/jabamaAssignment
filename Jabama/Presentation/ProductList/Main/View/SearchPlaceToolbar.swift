//
//  SearchPlaceToolbar.swift
//  Jabama
//
//  Created by Mohsen on 12/1/24.
//

import SwiftUI

struct SearchPlaceToolbar: View {
    @Environment(ProductListMainViewModel.self) var viewModel
    var body: some View {
        @Bindable var vm = viewModel
        ZStack{
            HStack(spacing:16){
                HStack{
                    Image(systemName: "magnifyingglass")
                        .foregroundStyle(.black)
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    TextField("Search", text: $vm.searchText)
                        
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
        }.background(.kAccent)
    }
}

#Preview {
    @Previewable @State var viewModel: ProductListMainViewModel = .init()
    VStack {
        SearchPlaceToolbar()
            .environment(viewModel)
        
        Spacer()
    }
}
