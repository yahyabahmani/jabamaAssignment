//
//  PlaceCard.swift
//  FiveSquare
//
//  Created by Shadi Ghelman on 11/23/24.
//

import SwiftUI


struct PlaceCard: View {
    struct Model {
        var imageUrl: URL?
        var name: String
        var type: String?
        var distance: Int?
    }
    
    let place: Model
    
    func imageView() -> some View {
        AsyncImage(url: place.imageUrl) { image in
            image.resizable()
                .aspectRatio(contentMode: .fill)
        } placeholder: {
            
        }
        .frame(width: 80, height: 80)
        .clipped()
        .background(Color(.systemFill))
    }
    func detailView() -> some View {
        VStack(alignment: .leading) {
            
            Text(place.name)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.headline)
            
            Text(place.type ?? "")
                .font(.subheadline)
            if let distance = place.distance {
                Text("Distance: \(distance)")
                    .font(.caption2)
            } else {
                Text("Distance: unavailable")
                    .font(.caption2)
            }
        }
    }

    var body: some View {
        HStack {
            imageView()
            detailView()
        }
        .padding(8)
        .overlay {
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color(.gray), lineWidth: 0.5)
        }
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    PlaceItem(
        place: .init(name: "Banafshi", type: "cofe", distance: 12)
    )

    .padding()
}
