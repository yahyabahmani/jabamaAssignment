//
//  NoNetworkView.swift
//  Jabama
//
//  Created by Mohsen on 12/3/24.
//

import SwiftUI

struct NoNetworkView: View {
    var body: some View {
        VStack(spacing:12){
            Image(systemName: "wifi.exclamationmark")
                .font(.largeTitle)
                .foregroundStyle(.black)
                
            Text("No Internet Connection")
                .font(.title2)
                .foregroundStyle(.black)
            
            Text("Please check your internet connection and try again.")
                .font(.body)
                .foregroundStyle(.black)
                .multilineTextAlignment(.center)
                
        }
        .padding()
        .frame(maxWidth: .infinity,maxHeight: .infinity)
        .background(.white)
    }
}

#Preview {
    NoNetworkView()
}
