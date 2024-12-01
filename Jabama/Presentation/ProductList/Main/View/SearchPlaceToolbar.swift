//
//  SearchPlaceToolbar.swift
//  Jabama
//
//  Created by Mohsen on 12/1/24.
//

import SwiftUI

struct SearchPlaceToolbar: View {
    @Binding var viewType:ProductListViewType
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
                    viewType = viewType == .list ? .map : .list
                }label: {
                    VStack(spacing:0){
                        Image(systemName: viewType == .list ? "list.bullet" : "globe")
                            .foregroundColor(.white)
                            .font(.title)
                            .fontWeight(.semibold)
                            .contentTransition(.symbolEffect(.replace, options: .nonRepeating))
                            .frame(width: 30, height: 30)
                        
//                        Text("\(viewType == .list ? "List" : "Map")")
//                            .foregroundColor(.white)
//                            .font(.buttonStrong)
                    }
                }
            }
            .padding(.horizontal,24)
            .padding(.vertical)
        }.background(.kAccent)
    }
}

#Preview {
    @Previewable @State var viewModel: ProductListMainViewModel = .init()
    @Previewable @State var viewType:ProductListViewType = .list
    VStack {
        SearchPlaceToolbar(viewType: $viewType)
            .environment(viewModel)
        
        Spacer()
    }
}
