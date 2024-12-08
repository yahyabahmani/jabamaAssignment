//
//  DependencyFactory.swift
//  jabamaAssignment
//
//  Created by Amir  on 07/12/2024.
//

@MainActor
final class DependencyFactory {
     func makeMapViewModel() -> MapViewModel {
        let networkManager = NetworkManager()
        let mapRepository = MapRepository(networkManager: networkManager)
        let getPlacesUseCase = GetPlacesUseCase(repository: mapRepository)
        return MapViewModel(getPlacesUseCase: getPlacesUseCase)
    }
    
     func makeSearchPlacesViewModel(query: String) -> SearchPlacesViewModel {
        let networkManager = NetworkManager()
        let searchRepository = SearchRepository(networkManager: networkManager)
        let searchPlacesUseCase = SearchPlacesUseCase(repository: searchRepository)
        return SearchPlacesViewModel(
            searchPlacesUseCase: searchPlacesUseCase,
            initialQuery: query
        )
    }
}
