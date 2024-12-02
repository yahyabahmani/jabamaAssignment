//
//  MapLoadingView.swift
//  Jabama
//
//  Created by Mohsen on 12/2/24.
//

import SwiftUI

struct MapLoadingView: View {
    var body: some View {
        ScrollView(.horizontal,showsIndicators: false){
            LazyHStack(spacing:12){
                ForEach(1...10,id: \.self){_ in
                    LoadingPlaceListItemView()
                }
                
            }
            .padding(.horizontal,8)
        }
        .frame(height: 200)
    }
}

#Preview {
    MapLoadingView()
}
