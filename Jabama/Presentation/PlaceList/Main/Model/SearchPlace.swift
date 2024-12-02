//
//  SearchPlace.swift
//  Jabama
//
//  Created by Mohsen on 12/1/24.
//

import Foundation

struct SearchPlace:Codable,Identifiable{
    let id:String?
    let categories: [Category]?
    let closedBucket: String?
    let dateClosed: String?
    let description: String?
    let distance: Double?
    let email: String?
    let fax: String?
    let geocodes: Geocodes?
    let hours: Hours?
    let hoursPopular: [PopularHour]?
    let link: String?
    let location: PlaceLocation?
    let menu: String?
    let name: String?
    let photos: [Photo]?
    let popularity: Double?
    let price: Double?
    let rating: Double?
    let stats: Stats?
    let tastes: [String]?
    let tel: String?
    let timezone: String?
    let tips: [Tip]?
    let venueRealityBucket: String?
    let verified: Bool?
    let website: String?
    
    
    enum CodingKeys:  String, CodingKey {
        case id = "fsq_id"
        case categories
        case dateClosed = "date_closed"
        case description
        case distance
        case email
        case fax
        case geocodes
        case hours
        case hoursPopular = "hours_popular"
        case link
        case location
        case menu
        case name
        case photos
        case popularity
        case price
        case rating
        case stats
        case tastes
        case tel
        case timezone
        case tips
        case venueRealityBucket = "venue_reality_bucket"
        case verified
        case website
        case closedBucket = "closed_bucket"
    }
}

extension SearchPlace{
    func firstCategory()->Category?{
        return categories?.first
    }
    
    func firstPhoto()->Photo?{
        return photos?.first
    }
    
    func score()->Double{
        return ((rating ?? 0)/2)
    }
    
    func distanceInKm()->String{
        return "\((distance ?? 0)/1000) km"
    }
    
    func lastTip()->String{
        return tips?.last?.text ?? ""
    }
}
