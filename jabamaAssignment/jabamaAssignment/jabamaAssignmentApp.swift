//
//  jabamaAssignmentApp.swift
//  jabamaAssignment
//
//  Created by Amir  on 04/12/2024.
//

import SwiftUI

@main
struct jabamaAssignmentApp: App {
    var body: some Scene {
        WindowGroup {
            let networkManager = NetworkManager()
            let mapRepository = MapRepository(networkManager: networkManager)
            let getPlacesUseCase = GetPlacesUseCase(repository: mapRepository)
            let mapViewModel = MapViewModel(getPlacesUseCase: getPlacesUseCase)
            MapView(viewModel: mapViewModel)
        }
    }
}
