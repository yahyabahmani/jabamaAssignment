//
//  PlaceListEmptyView.swift
//  Jabama
//
//  Created by Mohsen on 12/2/24.
//

import SwiftUI

struct PlaceListEmptyView: View {
    var body: some View {
        ZStack{
            Color.white.edgesIgnoringSafeArea(.all)
            VStack(spacing:16){
                Image(systemName: "binoculars")
                    .font(.largeTitle)
                    .foregroundStyle(.black)
                Text("Place List is Empty!")
                    .font(.title2)
                    .foregroundStyle(.black)
            }
        }
        
    }
}

#Preview {
    PlaceListEmptyView()
}
