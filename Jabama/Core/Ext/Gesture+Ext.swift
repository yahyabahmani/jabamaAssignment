//
//  Gesture+Ext.swift
//  Ludo
//
//  Created by Mohsen on 7/30/24.
//
import SwiftUI

struct PressAndReleaseModifier: ViewModifier {
    var onPressed: () -> Void
    var onRelease: () -> Void

    func body(content: Content) -> some View {
        content
            .simultaneousGesture(
                DragGesture(minimumDistance: 0)
                    .onChanged{ state in
                        
                        onPressed()
                    }
                    .onEnded{ _ in
                        onRelease()
                    }
            )
    }
}

extension View {
    func pressAndReleaseAction(onPressed: @escaping (() -> Void), onRelease: @escaping (() -> Void)) -> some View {
        modifier(PressAndReleaseModifier(onPressed: onPressed, onRelease: onRelease))
    }
}
