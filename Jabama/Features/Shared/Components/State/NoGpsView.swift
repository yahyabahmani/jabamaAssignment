//
//  NoGpsView.swift
//  Jabama
//
//  Created by Mohsen on 12/3/24.
//

import SwiftUI

struct NoGpsView: View {
    var onRetry: () -> Void = { }
    @State private var showBackground: Bool = false
    var body: some View {
        ZStack {
            Color.black.opacity(showBackground ? 0.4 : 0.0)
                .ignoresSafeArea()
            
            VStack(spacing:12){
                Image(systemName: "location.slash")
                    .font(.largeTitle)
                    .foregroundStyle(.black)
                
                Text("Location Not Available")
                    .font(.title2)
                    .foregroundStyle(.black)
                
                Text("Please check your Location Access settings and try again.")
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
            .padding()
            .frame(height:260)
            .frame(maxWidth: .infinity)
            .background(.white)
            .cornerRadius(20)
            .task {
                withAnimation(.easeInOut(duration: 0.6)){
                    showBackground = true
                }
            }
        }
    }
}

#Preview {
    NoGpsView()
}
