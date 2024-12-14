//
//  SearchPlaceQuery.swift
//  Jabama
//
//  Created by Mohsen on 12/2/24.
//

struct SearchPlaceQuery:DictionaryEncodable{
    var query: String = ""
    var ll: String = "35.7238539,51.3575036"
    var radius: Int = 22000
    var categories: String? = nil
    var limit: Int = 10
    var fields: String? = "fsq_id,name,categories,distance,rating,location,tips,price,stats,description,photos,geocodes"
    
}
