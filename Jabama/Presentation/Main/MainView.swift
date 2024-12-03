//
//  MainView.swift
//  Jabama
//
//  Created by Mohsen on 12/1/24.
//

import SwiftUI

struct MainView: View {
    
    /// Todo: after adding other views we can use global navigation View for now it's redundant

//    @StateObject private var router = MainRouter(isPresented: .constant(.placeList))
    
    var body: some View {
        
        ZStack {
            PlaceListMainView()
        }
        
       /// Todo: after adding other views we can use global navigation View for now it's redundant
        
        
//        RoutingView(router: router){
//            router.view(spec: .placeList, route: .navigation)
//        }
    }
}

#Preview {
    MainView()
}
