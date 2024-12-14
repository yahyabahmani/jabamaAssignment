# Jabama Technical Assignment

## Overview
This project demonstrates an iOS application built with MVVM, event-driven clean architecture, and SwiftUI, adhering to SOLID principles and ensuring separation of concerns. The codebase is modular, maintainable, and designed for scalability and ease of use.

## Key Application Features
- show a list of places with the ability to switch between list and map views.
- search for places in both list and map views.
- pagination based on foursquare API documentation in both list and map views.
- by scrolling in horizontal list the location of the place will be shown in the map.
- by clicking on Marker in the map, scroll view automatically scrolls to the place in the list.
- by moving map camera that location places will be shown in the list and map.
- by clicking on the place in the list, the map camera will move to the place location.
- implement all states for the project including loading, error, and empty states.
- implement disaster recovery for the project.

## Key Development Features

* **MVVM Architecture**: Views communicate with ViewModels via event-driven mechanisms.
* **Clean Architecture**: Modules are independent and loosely coupled.
* **Dependency Injection**: Ensures testability and flexibility.
* **Centralized Handlers**: Network Manager, Location Manager, Notification Manager, Navigation Manager and ...
* **Design Patterns**: Repository Pattern, Singletone, Factory, Observation, Builder.
* **Scalability**: Modular implementation with a focus on maintainable code.
* **Reusable Components**: Shared utilities, extensions, and styles.

## Folder Structure

### Core Module
The Core module acts as a reusable library containing shared resources across all `Application`.
- **Ext**: Contains extensions for Foundation, UIKit, and SwiftUI.
- **Injection**: Contains the Dependency Injection container.
- **Models**: Contains shared models in `App` level.
- **Navigation**: Centralized navigation manager with view Specifications.
- **Network**: Centralized network manager with tools for logging and builder for requests.
- **Other**: Contains Centralized Handlers, Notification Manager, Location Manager, and ...
- **Shapes**: Contains custom shapes for SwiftUI views.
- **Utils**: Contains shared utilities for date formatting, App, and more.
- **Views**: Contains shared views and view modifiers.

### Presentation Module
The Presentation module contains the UI layer Modules.
#### App 
- Contains the main entry point for the application.
- Root module of the application, responsible for initial setup and dependency injection.
- Constants and configurations are defined here.

#### Main
- Contains high-level Features logic, including navigation between feature modules 
- Contains shared `ViewModel`

#### Shared
Contains shared views and view models across the Features.
-  **Models**: Commonly used data models.
-  **Styles**: Centralized styling components.
-  **Utils**: Reusable utilities.
-  **Components**: Shared UI elements.
-  **Extensions**: Shared Swift extensions.
- 
#### PlaceList
this Feature is responsible for displaying a list of places.it contains of 3 main parts:
- **main**: this package contains all the shared thins that are used in list and map views including:
    - **Models**: Contains the models that are used in the list and map views.
    - **Views**: Contains the shared views that are used in the list and map views.
    - **ViewModel**: Contains the shared viewModel that are used in the list and map views.
    - **Repository**: Contains the shared repository that are used in the list and map views.
    - **Events**: Contains the shared events that are used in the list and map views.
- **List**: this package contains all the things that are used in the list view including:
    - **Views**: Contains the views that are used in the list view.
    - **ViewModel**: Contains the viewModel that are used in the list view.
    - **Models**: Contains the models that are used in the list view.
- **Map**: this package contains all the things that are used in the map view including:
    - **Views**: Contains the views that are used in the map view.
    - **ViewModel**: Contains the viewModel that are used in the map view.
    - **Models**: Contains the models that are used in the map view.
    - **Events**: Contains the events that are used in the map view.
  
#### PlaceDetail: Contains the views and viewModel for the PlaceDetail feature.
this Feature only added for showing the Modularity of the project, and it's not completed.
#### Settings: Contains the views and viewModel for the Settings feature.
this Feature only added for showing the Modularity of the project, and it's not completed.
#### Auth: Contains the views and viewModel for the Auth feature.
this Feature only added for showing the Modularity of the project, and it's not completed.

### Supporting Files
this folder contains the supporting files for the project including:
- **Assets**: Contains the assets for the project.
- **Localization**: Contains the localization files for the project.

## Installation
- place your api key in the `AppConstants` file.

## Notes

- pagination is implemented based on the foursquare API documentation with max of 50 items just for limit.(I could not find any information for page)
- Most of the places rating in iran is null, so I set the rating to 0 for them.
- the search is searching based on location. so if you change map camera location it will search based on that location.(this is the policy that I have chosen for the project)
- default radius of search is 22,000 as foursquare.
- by scrolling the list you can see the location of the place in the map. but if you search or change the map camera location it will be `disabled`. for `enabling` it just click in one of horizontal list items.
- location fetching is automatically stops when user location is found.(custom policy)
- I added some sample modules for showing the modularity of the project. but they are not completed.
- in Core Module you may see some extra utils. I keep them for showing some of the utilities that I have used in my projects.
- I tested the project and it's working fine. but still there might be some bugs that I have not found.
- I didn't focus on UI design and I just used the default design of the project.
- I didn't implement any extra feature that is not mentioned in the assignment.
- I didn't implement any extra test for the project because it was not mentioned in the assignment.(I can add Unit and UI tests if you want)

## Some Showcases

### Injection
```Swift
@Inject private var agent: NetworkAgent
```

### Builder pattern For Network Requests
```Swift
    func searchPlaces(query: SearchPlaceQuery) -> AnyPublisher<SearchPlaceRes, ErrorModel> {
        let builder = RequestBuilder()
            .setEndpoint("places/search")
            .addParameters(query.dictionary() ?? [:])
            .setMethod(.get)
        
        return agent.runReq(builder.build())
    }
```

### Centralized Navigation
```Swift
    @StateObject private var router = MainRouter(isPresented: .constant(.placeList))
    
    var body: some View {
        RoutingView(router: router){
            router.view(spec: .placeList, route: .navigation)
        }
    }
```

### Centralized Network Manager
```Swift
    URLSession.shared
            .dataTaskPublisher(for: request)
            .tryMap {}
            .decode(type:T.self, decoder: JSONDecoder())
            .mapError {}
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
```

### Event-Driven Communication
```Swift
enum PlaceListEvent {
    case changeViewType
    case loadMore
    case onSearchTextChanged(String)
    case onLocationChange(AppLocation)
    case fetchPlaces
    case changeGpsStatus(Bool)
    case changeNetworkStatus(Bool)
}

viewModel.onEvent(.fetchPlaces)

override func onEvent(_ event: PlaceListEvent) {
        switch event {
        case .changeViewType:
            changeViewType()
        case .loadMore:
            if canLoadMore{
                fetchPlaces(currentLimit + 10,isSilent: true)
            }
        case .onSearchTextChanged(let query):
            onSearchTextChanged(query)
            
        case .onLocationChange(let location):
            self.onLocationChange(location)
        case .fetchPlaces:
            self.fetchPlaces()
        case .changeGpsStatus(let isAvailable):
            self.isLocationAvailable = isAvailable
        case .changeNetworkStatus(let isAvailable):
            self.isNetworkAvailable = isAvailable
        }
    }

```
