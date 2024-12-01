//
//  NamespaceWrapper.swift
//  Ludo
//
//  Created by mohsen mokhtari on 5/23/23.
//

import SwiftUI
class NamespaceWrapper: ObservableObject {
    var namespace: Namespace.ID

    init(_ namespace: Namespace.ID) {
        self.namespace = namespace
    }
}
