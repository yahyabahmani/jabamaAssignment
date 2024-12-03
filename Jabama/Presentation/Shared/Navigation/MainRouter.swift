//
//  MainRouter.swift
//  rocket
//
//  Created by mohsen mokhtari on 6/12/23.
//

import SwiftUI

class MainRouter: Router<MainViewSpec> {



    func presentAuthView() {
        navigateTo(.auth)
    }

    func presentProfile() {
        navigateTo(.profile)
    }

    func presentPlaceList() {
        navigateTo(.placeList)
    }

    func presentPlaceDetail(_ placeId: String) {
        navigateTo(.placeDetail(placeId))
    }




    override func view(spec: MainViewSpec, route: Route) -> AnyView {
        AnyView(buildView(spec: spec, route: route))
    }
}

private extension MainRouter {

    @ViewBuilder
    func buildView(spec: MainViewSpec, route: Route) -> some View {
        switch spec {
        case .auth:
            AuthMainView()
        case .placeList:
            PlaceListMainView()
        case.placeDetail(let placeId):
            PlaceDetailView(placeId: placeId)
        case .profile:
            ProfileSampleView()
        }
    }

    func router(route: Route) -> MainRouter {
        switch route {
        case .navigation:
            return self
        case .sheet:
            return MainRouter(isPresented: presentingSheet)
        case .fullScreenCover:
            return MainRouter(isPresented: presentingFullScreen)
        case .modal:
            return self
        }
    }
}
