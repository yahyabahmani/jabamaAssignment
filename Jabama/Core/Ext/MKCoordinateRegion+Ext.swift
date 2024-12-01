//
//  MKCoordinateRegion+Ext.swift
//  Ludo
//
//  Created by mohsen mokhtari on 7/12/23.
//


import MapKit
import SwiftUI
extension MKCoordinateRegion {
    
    static func MandellaRegion() -> MKCoordinateRegion {
        MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 35.763397, longitude:51.417525), latitudinalMeters: 0.01, longitudinalMeters: 0.01)
    }
    
    func getBinding() -> Binding<MKCoordinateRegion>? {
        return Binding<MKCoordinateRegion>(.constant(self))
    }
}
