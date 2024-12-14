//
//  JabamaApp.swift
//  Jabama
//
//  Created by Mohsen on 12/1/24.
//

import SwiftUI
import SDWebImageSwiftUI

@main
struct JabamaApp: App {
    init(){
        registerDependencies()
    }
    
    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }
    
    private func registerDependencies(){
        DependencyResolver.register(type: NetworkAgent.self,as: .singleton, NetworkAgent())
        DependencyResolver.register(type: PlaceListApiService.self, PlaceListApiService())
        DependencyResolver.register(type: PlaceListRepo.self, PlaceListRepoImpl())
    }
    
    private func preConfigure(){
        SDWebImageDownloader.shared.setValue(AppConstants.API_KEY, forHTTPHeaderField: "Authorization")
    }
}
