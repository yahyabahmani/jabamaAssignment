//
//  Transition+Ext.swift
//  Ludo
//
//  Created by Mohsen on 7/24/24.
//

import SwiftUI

extension AnyTransition {
    static var backslide: AnyTransition {
        AnyTransition.asymmetric(
            insertion: .move(edge: .trailing),
            removal: .move(edge: .leading))}
}
