//
//  JabamaApp.swift
//  Jabama
//
//  Created by Mohsen on 12/1/24.
//

import SwiftUI

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
        DependencyResolver.register(type: ProductListApiService.self, ProductListApiService())
        DependencyResolver.register(type: ProductListRepo.self, ProductListRepoImpl())
    }
}
