//
//  AppUtils.swift
//  Ludo
//
//  Created by mohsen mokhtari on 9/15/23.
//

import Foundation
import Defaults

struct AppUtils{
   static func isUserLoggedIn()->Bool{
        return Defaults[.token] != nil
    }
    
    static func logout(){
        Defaults.removeAll()
        Defaults[.isOnboardingPresented] = true
    }
    
    static func getToken()->String?{
        return Defaults[.token]
    }
    
    static func saveToken(token:String){
        Defaults[.token] = token
    }

    static func getFcmToken()->String?{
        return Defaults[.fcmToken]
    }
    static func saveFcmToken(token:String){
        Defaults[.fcmToken] = token
    }
    
    
    
}
