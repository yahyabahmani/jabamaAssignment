//
//  MainViewSpec.swift
//  rocket
//
//  Created by mohsen mokhtari on 6/12/23.
//

import SwiftUI

enum MainViewSpec: ViewSpec {
    case auth
    case placeDetail(String)
    case placeList
    case profile
    
}
extension MainViewSpec: Identifiable {
    
    var id: Self { self }
}
