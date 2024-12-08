//
//  PlacesListView.swift
//  jabamaAssignment
//
//  Created by Amir  on 06/12/2024.
//

import SwiftUI

struct PlaceCardView: View {
    var place: Place
    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: "heart.fill")
                .font(.system(size: 50))
                .foregroundStyle(Color.red)
            VStack(alignment: .leading) {
                Text(place.name)
                    .font(.headline)
                if let address = place.location?.address {
                    Text(address)
                        .font(.subheadline)
                }               
            }
        }
        .frame(maxWidth:.infinity, alignment: .leading)
        .padding()
    }
}

#Preview {
    if let firstMockPlace = mockPlace.first {
        PlaceCardView(place: firstMockPlace)
    } else {
        EmptyView()
    }
}
