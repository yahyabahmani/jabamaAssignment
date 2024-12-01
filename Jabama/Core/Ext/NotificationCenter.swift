//
//  NotificationCenter.swift
//  Ludo
//
//  Created by mohsen mokhtari on 9/21/23.
//

import Foundation

extension NSNotification {
    static let unauthorized = Notification.Name.init("Unauthorized")
    static let getUserKey = Notification.Name.init("GetUser")
    static let channgeBottomNavigationStatusKey =  Notification.Name.init("HideBottomNavigation")
    static let vaultViewKey = Notification.Name.init("VaultView")
    
    static func makeUnauthorized(isUnauthorized:Bool) {
        let dic = ["isUnauthorized":isUnauthorized]
        NotificationCenter.default.post(name: unauthorized, object: nil,userInfo: dic)
    }
}
