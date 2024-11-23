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
        places: (1...10).map { _ in .dummy() },
        scrollPosition: .constant(nil)
    )
    .background(.yellow)
}
