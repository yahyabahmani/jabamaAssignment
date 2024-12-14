//
//  AppConstants.swift
//  Jabama
//
//  Created by Mohsen on 12/1/24.
//

import Foundation

struct AppConstants {
#if DEBUG
static let BASE_URL = URL(string: "https://api.foursquare.com/v3/")!
static let API_KEY = "fsq3w4QfcEVJPD+7CWBpIoJL9sDMQJLm3wcfuHKk0nJyli0="

#else
static let BASE_URL = URL(string: "https://api.foursquare.com/v3/")!
static let API_KEY = "fsq3w4QfcEVJPD+7CWBpIoJL9sDMQJLm3wcfuHKk0nJyli0="
#endif
}
