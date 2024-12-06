//
//  PlacesResponse.swift
//  jabamaAssignment
//
//  Created by Amir  on 05/12/2024.
//


import Foundation

struct PlacesResponse: Codable {
    let results: [Place]
    let context: Context
    struct Context: Codable {
        let geo_bounds: GeoBounds
        
        struct GeoBounds: Codable {
            let circle: Circle
            
            struct Circle: Codable {
                let center: Center
                let radius: Double
                
                struct Center: Codable {
                    let latitude: Double
                    let longitude: Double
                }
            }
        }
    }
}

struct Place: Codable, Identifiable {
    let fsq_id: String
    let name: String
    let location: Location
    let distance: Int?
    let categories: [Category]
    let chains: [Chain]
    let closed_bucket: String
    let geocodes: Geocodes
    let link: String
    let timezone: String

    var id: String { fsq_id }

    struct Location: Codable {
        let address: String
        let formatted_address: String
        let locality: String?
        let region: String?
        let postcode: String?
        let country: String?
    }
    
    struct Category: Codable {
        let id: Int
        let name: String
        let short_name: String
        let plural_name: String
        let icon: Icon
        
        struct Icon: Codable {
            let prefix: String
            let suffix: String
        }
    }
    
    struct Chain: Codable {
        let id: String
        let name: String
    }
    
    struct Geocodes: Codable {
        let main: Coordinate
        let roof: Coordinate?
        
        struct Coordinate: Codable {
            let latitude: Double?
            let longitude: Double?
        }
    }
}
