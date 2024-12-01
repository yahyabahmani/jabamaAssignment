//
//  View+Ext.swift
//  Fitness
//
//  Created by mohsen mokhtari on 9/10/23.
//

import SwiftUI
import Combine

extension View {
    func vAlign(_ alignment: Alignment) -> some View {
        self.frame(maxHeight: .infinity, alignment: alignment)
    }

    func hAlign(_ alignment: Alignment) -> some View {
        self.frame(maxWidth: .infinity, alignment: alignment)
    }

    func border(_ width: CGFloat, _ color: Color) -> some View {
        self
            .padding(.horizontal, 15)
            .padding(.vertical, 10)
            .background {
            RoundedRectangle(cornerRadius: 5, style: .continuous)
                .stroke(color, lineWidth: width)
        }
    }

    func fillView(_ color: Color) -> some View {
        self
            .padding(.horizontal, 15)
            .padding(.vertical, 10)
            .background {
            RoundedRectangle(cornerRadius: 5, style: .continuous)
                .fill(color)
        }
    }

    func disabledWithOpacity(_ condition: Bool) -> some View {
        self
            .disabled(condition)
            .opacity(condition ? 0.6 : 1)
    }

    func closeKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }

    @available(iOS 14, *)
    func navigationBarTitleTextColor(_ color: Color) -> some View {
        let uiColor = UIColor(color)

        // Set appearance for both normal and large sizes.
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: uiColor]
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: uiColor]

        return self
    }
    
    func getRect()->CGRect{
        return UIScreen.main.bounds
    }
    
    
    @ViewBuilder func unredacted(when condition: Bool) -> some View {
        if condition {
            unredacted()
        } else {
            // Use default .placeholder or implement your custom effect
            redacted(reason: .placeholder)
        }
    }
    
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {

        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
    
    func getRootViewController() -> UIViewController {
            guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
                return .init()
            }

            guard let root = screen.windows.first?.rootViewController else {
                return .init()
            }
            

            return root
        }
    
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
            clipShape( RoundedCorner(radius: radius, corners: corners) )
        }
    
    func onReceive(timer: TimePublisher?, perform action: @escaping (Timer.TimerPublisher.Output) -> Void) -> some View {
            Group {
                if let timer = timer {
                    self.onReceive(timer, perform: { value in
                        action(value)
                    })
                } else {
                    self
                }
            }
        }
    func roundedCornerWithBorder(lineWidth: CGFloat = 1, borderColor: Color, radius: CGFloat = 8, corners: UIRectCorner = [.allCorners]) -> some View {
               clipShape(RoundedCorner(radius: radius, corners: corners) )
                   .overlay(RoundedCorner(radius: radius, corners: corners)
                       .stroke(borderColor, lineWidth: lineWidth))
           }
    
    @ViewBuilder func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
    @ViewBuilder
        func shimmer(_ config: ShimmerConfig) -> some View {
            self
                .modifier(ShimmerEffectHelper(config: config))
        }
    
    @ViewBuilder
    func shine(_ toggle: Bool, duration: CGFloat = 0.5, clipShape: some Shape = .rect, x: CGFloat = 1.0, y: CGFloat = 1.0) -> some View {
            self
                .overlay {
                    GeometryReader {
                        let size = $0.size
                        let moddedDuration = max(0.3, duration)
                        Rectangle()
                            .fill(.linearGradient(
                                colors: [
                                    .clear,
                                    .clear,
                                    .white.opacity(0.1),
                                    .white.opacity(0.5),
                                    .white.opacity(1),
                                    .white.opacity(0.5),
                                    .white.opacity(0.1),
                                    .clear,
                                    .clear
                                ],
                                startPoint: .leading,
                                endPoint: .trailing)
                            )
                            .scaleEffect(y: 8)
                            .keyframeAnimator(initialValue: 0.0, trigger: toggle, content: { content, progress in
                                content
                                    .offset(x: -size.width + progress * size.width * 2)
                            }, keyframes: { _ in
                                CubicKeyframe(.zero, duration: 0.1)
                                CubicKeyframe(1, duration: moddedDuration)
                            })
                            .rotationEffect(.init(degrees: 45))
                            .scaleEffect(x: x, y: y)
                    }
                }
                .clipShape(clipShape)
        }
    
    
}

typealias TimePublisher = Publishers.Autoconnect<Timer.TimerPublisher>


struct SizeKey: PreferenceKey {
    static var defaultValue: CGSize = .zero
    
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        value = nextValue()
    }
}
