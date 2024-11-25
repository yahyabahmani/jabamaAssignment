//
//  ScrollView.offsetReader.swift
//  FiveSquare
//
//  Created by Shadi Ghelman on 11/25/24.
//

import Combine
import SwiftUI

extension View {
    func onScroll(
        started: @escaping () -> Void = { },
        finished: @escaping () -> Void = { }
    ) -> some View {
        background {
            ScrollViewOffsetReader(
                onScrollingStarted: started, onScrollingFinished: finished
            )
        }
    }
}

private struct ScrollViewOffsetReader: View {
    private let onScrollingStarted: () -> Void
    private let onScrollingFinished: () -> Void
    
    private let detector = CurrentValueSubject<CGFloat, Never>(0)
    private let publisher: AnyPublisher<CGFloat, Never>
    @State private var scrolling: Bool = false
    
    @State private var lastValue: CGFloat = 0
    
    init(
        onScrollingStarted: @escaping () -> Void = {},
        onScrollingFinished: @escaping () -> Void = {},
        debounce: DispatchQueue.SchedulerTimeType.Stride = .seconds(0.1)
    ) {
        self.onScrollingStarted = onScrollingStarted
        self.onScrollingFinished = onScrollingFinished
        self.publisher = detector
            .debounce(for: debounce, scheduler: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    var body: some View {
        GeometryReader { g in
            let offset = g.frame(in: .global).origin.x
            Rectangle()
                .frame(width: 0, height: 0)
                .onChange(of: offset) {
                    if !scrolling {
                        scrolling = true
                        onScrollingStarted()
                    }
                    detector.send(offset)
                }
                .onReceive(publisher) {
                    scrolling = false
                    
                    guard lastValue != $0 else { return }
                    lastValue = $0
                    
                    onScrollingFinished()
                }
        }
    }
}
