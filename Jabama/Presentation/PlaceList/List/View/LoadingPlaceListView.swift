//
//  LoadingPlaceListView.swift
//  Jabama
//
//  Created by Mohsen on 12/2/24.
//

import SwiftUI

struct LoadingPlaceListView: View {
    var body: some View {
        ScrollView(.vertical,showsIndicators: false){
            LazyVStack{
                ForEach(0..<10){ index in
                    LoadingPlaceListItemView()
                }
            }.padding()
        }
    }
}

#Preview {
    LoadingPlaceListView()
}
