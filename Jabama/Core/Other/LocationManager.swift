//
//  LocationManager.swift
//  Ludo
//
//  Created by Mohsen on 7/4/24.
//

import Foundation
import Combine
import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate {
    @ObservationIgnored
    var objectWillChange = PassthroughSubject<Void, Never>()
    @ObservationIgnored
    var degrees: Double = 0 {
        didSet {
            objectWillChange.send()
        }
    }
    @ObservationIgnored
    private var stopped: Bool = false
    @ObservationIgnored
    private let locationManager: CLLocationManager
    @Published var lastKnownLocation: CLLocationCoordinate2D?

    
    override init() {
        self.locationManager = CLLocationManager()
        super.init()
        
        self.locationManager.delegate = self
        
    }
    
    func start() {
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.headingAvailable() {
            self.stopped = false
            self.locationManager.startUpdatingLocation()
            self.locationManager.startUpdatingHeading()
        }
    }
    
     func stopUpdating() {
        self.stopped = true
        self.locationManager.stopUpdatingLocation()
        self.locationManager.stopUpdatingHeading()
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        let heading = newHeading.trueHeading > 0 ? newHeading.trueHeading : newHeading.magneticHeading
        if !stopped {
            degrees = heading
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {//Trigged every time authorization status changes
            checkLocationAuthorization()
        }
        
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            lastKnownLocation = locations.first?.coordinate
        }
    
    func checkLocationAuthorization() {
            
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
            
            switch locationManager.authorizationStatus {
            case .notDetermined:
                locationManager.requestWhenInUseAuthorization()
                
            case .restricted:
                print("Location restricted")
                
            case .denied:
                print("Location denied")
                
            case .authorizedAlways:
                print("Location authorizedAlways")
                
            case .authorizedWhenInUse:
                lastKnownLocation = locationManager.location?.coordinate
                
            @unknown default:
                print("Location service disabled")
            
            }
        }
    
    func getStatus() -> CLAuthorizationStatus {
        return locationManager.authorizationStatus
    }
    
    func locationToDegree(
       _ tagetLatitude:Double,
       _ targetLongitude:Double
   ) -> Double {
       guard let lastKnownLocation = lastKnownLocation else {
           return -1
       }
       let a = lastKnownLocation
       let b = CLLocationCoordinate2D(latitude: tagetLatitude, longitude: targetLongitude)
       let deltaL = b.longitude.toRadians - a.longitude.toRadians
       let thetaB = b.latitude.toRadians
       let thetaA = a.latitude.toRadians
       let x = cos(thetaB) * sin(deltaL)
       let y = cos(thetaA) * sin(thetaB) - sin(thetaA) * cos(thetaB) * cos(deltaL)
       let bearing = atan2(x,y)
       let bearingInDegrees = bearing.toDegrees
       return abs(bearingInDegrees)
   }
    
    @MainActor
    static func isLocationPermissionGranted() -> Bool
    {
        switch CLLocationManager().authorizationStatus {
              case .notDetermined:
                 return false
              case .restricted, .denied:
                 return false
              case .authorizedWhenInUse, .authorizedAlways:
                return true
        @unknown default:
            return false
        }
    }
    
    
}

extension Double {
    var toRadians : Double {
        var m = Measurement(value: self, unit: UnitAngle.degrees)
        m.convert(to: .radians)
        return m.value
    }
    var toDegrees : Double {
        var m = Measurement(value: self, unit: UnitAngle.radians)
        m.convert(to: .degrees)
        return m.value
    }
}
