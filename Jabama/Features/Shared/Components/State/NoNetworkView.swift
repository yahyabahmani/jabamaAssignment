//
//  NoNetworkView.swift
//  Jabama
//
//  Created by Mohsen on 12/3/24.
//

import SwiftUI

struct NoNetworkView: View {
    var onRetry: () -> Void = { }
    @State private var showBackground: Bool = false
    var body: some View {
        ZStack {
            Color.black.opacity(showBackground ? 0.4 : 0.0)
                .ignoresSafeArea()
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
                
                Button {
                    onRetry()
                }label: {
                    Text("Retry")
                        .font(.headline)
                        .foregroundStyle(.blue)
                }
                .buttonStyle(.plain)
                
            }
            .frame(height:260)
            .padding()
            .frame(maxWidth: .infinity)
            .background(.white)
            .cornerRadius(20)
            .task {
                withAnimation(.easeInOut(duration: 0.5)){
                    showBackground = true
                }
            }
        }
    }
}

#Preview {
    NoNetworkView()
}
