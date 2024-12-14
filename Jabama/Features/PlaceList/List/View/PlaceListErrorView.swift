//
//  PlaceListErrorView.swift
//  Jabama
//
//  Created by Mohsen on 12/2/24.
//

import SwiftUI

struct PlaceListErrorView: View {
    var message: String?
    var body: some View {
        ZStack{
            Color.white.edgesIgnoringSafeArea(.all)
            VStack(spacing:16){
                Image(systemName: "exclamationmark.warninglight")
                    .font(.largeTitle)
                    .foregroundStyle(.black)
                Text(message ?? "Something went wrong!")
                    .font(.title2)
                    .foregroundStyle(.black)
            }
        }
    }
}

#Preview {
    PlaceListErrorView()
}
