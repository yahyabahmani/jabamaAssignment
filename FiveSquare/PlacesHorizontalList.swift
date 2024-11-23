//
//  PlacesHorizontalList.swift
//  FiveSquare
//
//  Created by Shadi Ghelman on 11/23/24.
//

import SwiftUI

struct PlacesHorizontalList: View {
    typealias Model = PlaceCard.Model
    
    var places: [Model]
    @Binding var scrollPosition: Model.ID?

    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack {
                ForEach(places) { place in
                    PlaceCard(place: place)
                        .frame(width: 300)
                }
            }
            // Tell the lazy stack to fix the height
            .frame(height: 120)
            // Add some space for the scrollbar
            .padding(.bottom)
            // Track the position
            .scrollTargetLayout()
        }
        .scrollPosition(id: $scrollPosition)
        .safeAreaPadding(.horizontal, 20)
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    PlacesHorizontalList(
        places: (1...10).map {
            let randomName = UUID().uuidString.prefix(Int.random(in: 5...15))
            return .init(
                id: "\($0)",
                name: String(randomName),
                type: "Restaurant",
                distance: $0 * 10
            )
        },
        scrollPosition: .constant(nil)
    )
    .background(.yellow)
}
