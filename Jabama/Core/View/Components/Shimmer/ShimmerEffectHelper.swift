//
//  ShimmerEffectHelper.swift
//  Xplorify
//
//  Created by Mohsen on 11/18/24.
//

import SwiftUI

struct ShimmerEffectHelper: ViewModifier {

    var config: ShimmerConfig
    @State private var moveTo: CGFloat = -0.7

    func body(content: Content) -> some View {
        content
            .overlay {
                RoundedRectangle(cornerRadius: 5)
                    .fill(.clear)
                    .mask {
                        content
                    }
                    .overlay {
                        GeometryReader {
                            let size = $0.size
                            let extraOffset = (size.height / 2.5) + config.blur
                            
                            Rectangle()
                                .fill(config.highlight)
                                .mask {
                                    RoundedRectangle(cornerRadius: 5)
                                        .fill(
                                            .linearGradient(colors: [
                                                .white.opacity(0),
                                                config.highlight.opacity(config.highlightOpacity),
                                                .white.opacity(0)
                                            ], startPoint: .top, endPoint: .bottom)
                                        )
                                        .blur(radius: config.blur)
                                        .rotationEffect(.init(degrees: -70))
                                        .offset(x: moveTo > 0 ? extraOffset : -extraOffset)
                                        .offset(x: size.width * moveTo)
                                }
                                .blendMode(config.blendMode)
                        }
                        .mask {
                            content
                        }
                    }
                    .onAppear {
                        DispatchQueue.main.async {
                            moveTo = 0.7
                        }
                    }
                    .animation(.linear(duration: config.speed).repeatForever(autoreverses: false), value: moveTo)
            }
    }
}
