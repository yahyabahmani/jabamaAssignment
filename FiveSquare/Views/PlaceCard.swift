//
//  PlaceCard.swift
//  FiveSquare
//
//  Created by Shadi Ghelman on 11/23/24.
//

import SwiftUI

struct PlaceCard: View {
    let place: Model

    private let radius: CGFloat = 16
    private let lineWidth: CGFloat = 1
    private let contentPadding: CGFloat = 8

    func imageView() -> some View {
        AsyncImage(url: place.imageUrl) { image in
            image.resizable()
                .aspectRatio(contentMode: .fill)
        } placeholder: {
            Image(systemName: "photo")
                .imageScale(.large)
                .foregroundStyle(.gray)
        }
        .frame(width: 80, height: 80)
        .background(.background.secondary)
        .clipShape(.rect(cornerRadius: radius - contentPadding - lineWidth))
    }

    var distanceLabel: String {
        if let distance = place.distance {
            "Distance: \(distance)"
        } else {
            "Unmeasurable distance"
        }
    }

    func detailView() -> some View {
        VStack(alignment: .leading) {
            Text(place.name)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.headline)

            Text(place.type ?? "")
                .font(.subheadline)

            Text(distanceLabel)
                .font(.caption2)
        }
    }

    var body: some View {
        HStack {
            imageView()
            detailView()
        }
        .padding(contentPadding)
        .overlay {
            RoundedRectangle(cornerRadius: radius)
                .strokeBorder(lineWidth: lineWidth)
                .foregroundStyle(.background.secondary)
        }
        .background(Color(.systemBackground), in: .rect(cornerRadius: radius))
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    PlaceCard(
        place: .init(
            id: "1",
            imageUrl: .init(string: "https://i.sstatic.net/mv2C45Ds.jpg"),
            name: "Sushiant",
            type: "Restaurant",
            distance: 12
        )
    )
    .padding()
    .background(.pink)
}
