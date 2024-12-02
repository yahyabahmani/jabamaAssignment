//
//  RatingView.swift
//  Jabama
//
//  Created by Mohsen on 12/2/24.
//

import SwiftUI

struct RatingView: View {
    var rating:Double
    var body: some View {
        RoundedRectangle(cornerRadius: 8)
            .fill(getRatingColor().opacity(0.8))
            .frame(width: 50,height:50)
            .shadow(color:getRatingColor().opacity(0.1),radius: 10)
            .overlay{
                Text("\(rating.removeZerosFromEnd())")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
            }
    }
    
    private func getRatingColor() -> Color {
        if rating > 7 {
            return .green
        } else if rating > 5 {
            return .yellow
        }
        if rating > 3 {
            return .orange
        }
        else {
            return .red
        }
    }
}

#Preview {
    RatingView(rating:5.5)
}
