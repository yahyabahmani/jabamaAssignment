//
//  NetworkErrorView.swift
//  jabamaAssignment
//
//  Created by Amir  on 08/12/2024.
//

import SwiftUI

struct NetworkErrorView: View {
    let errorMessage: String
    let onRetry: () -> Void // Closure for the retry action

    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "wifi.exclamationmark")
                .resizable()
                .scaledToFit()
                .frame(width: 60, height: 60)
                .foregroundColor(.red)
            
            Text("Network Error")
                .font(.headline)
                .foregroundColor(.primary)
            
            Text(errorMessage)
                .font(.subheadline)
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
                .padding(.horizontal)
            
            Button(action: {
                onRetry() // Call the closure when the button is tapped
            }) {
                Text("Retry")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.horizontal, 20)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color(.systemBackground))
                .shadow(radius: 5)
        )
        .padding()
    }
}

#Preview {
    NetworkErrorView(errorMessage: "some error", onRetry: {})
}
