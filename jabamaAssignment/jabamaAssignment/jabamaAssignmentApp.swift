//
//  jabamaAssignmentApp.swift
//  jabamaAssignment
//
//  Created by Amir  on 04/12/2024.
//

import SwiftUI

@main
struct JabamaAssignmentApp: App {
    private let factory = DependencyFactory()

    var body: some Scene {
        WindowGroup {

            let mapViewModel = factory.makeMapViewModel()
            MapView(
                viewModel: mapViewModel,
                searchPlacesViewModelFactory: factory.makeSearchPlacesViewModel()
            )
        }
    }
}
