//
//  ProductListMainView.swift
//  Jabama
//
//  Created by Mohsen on 12/1/24.
//

import SwiftUI

struct ProductListMainView: View {
    @State private var viewModel: ProductListMainViewModel = .init()
    var body: some View {
        GeometryReader { geometry in
            let _ = geometry.size
            
            ZStack(alignment:.top){
                SearchPlaceToolbar()
                    .environment(viewModel)
                
            }
        }
    }
}

#Preview {
    ProductListMainView()
}
