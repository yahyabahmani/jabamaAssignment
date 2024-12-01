//
//  ProductListMainView.swift
//  Jabama
//
//  Created by Mohsen on 12/1/24.
//

import SwiftUI

struct ProductListMainView: View {
    @State private var viewModel: ProductListMainViewModel = .init()
    @State private var viewType: ProductListViewType = .list
    var body: some View {
        GeometryReader { geometry in
            let _ = geometry.size
            
            ZStack(alignment:.top){
                SearchPlaceToolbar(viewType: $viewType)
                    .environment(viewModel)
                
            }
        }
    }
}

#Preview {
    ProductListMainView()
}
