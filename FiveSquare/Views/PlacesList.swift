//
//  PlacesHorizontalList.swift
//  FiveSquare
//
//  Created by Shadi Ghelman on 11/23/24.
//

import SwiftUI

struct PlacesList: View {
    typealias Model = PlaceCard.Model

    var axes: Axis.Set = .horizontal
    var places: [Model]
    @Binding var scrollPosition: Model.ID?

    var onLastAppear: () -> Void = { print("Last item appeared") }
    var isLoading: Bool = false

    @State private var isScrolling = false
    private let extraPadding: CGFloat = 16

    private func placeholderCard() -> some View {
        PlaceCard(place: .dummy())
            .redacted(reason: .placeholder)
    }

    @ViewBuilder
    private func layout<Content: View>(@ViewBuilder content: () -> Content) -> some View {
        switch axes {
        case .horizontal: LazyHStack { content() }
            // Track the position
            .scrollTargetLayout()
        case .vertical: LazyVStack { content() }
            // Track the position
            .scrollTargetLayout()
        default: ZStack { content() }
        }
    }

    var body: some View {
        ScrollView(axes) {
            layout {
                ForEach(places) { place in
                    PlaceCard(place: place)
                        .containerRelativeFrame(.horizontal) { length, _ in
                            length - extraPadding
                        }
                }

                if isLoading {
                    placeholderCard()
                        .containerRelativeFrame(.horizontal) { length, _ in
                            length - extraPadding
                        }
                }
            }
            // Tell the lazy stack to fix the height
            .frame(maxHeight: axes == .horizontal ? 120 : .infinity)
            // Add some space for the scrollbar
            .padding(.bottom)
            // Observe scroll movements
            .onScroll(
                started: { isScrolling = true },
                finished: { isScrolling = false }
            )
        }
        .scrollPosition(id: $scrollPosition, anchor: .bottom)
        .safeAreaPadding(.horizontal, axes == .horizontal ? 20 : 0)
        // Observe the last item to appearance load more
        .onChange(of: scrollPosition) {
            if scrollPosition == places.last?.id {
                onLastAppear()
            }
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    PlacesList(
        places: (1 ... 10).map { _ in .dummy() },
        scrollPosition: .constant(nil)
    )
    .background(.yellow)
}
