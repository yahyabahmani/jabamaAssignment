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
static let API_KEY = "fsq3uPDlRL0+L+hC4R4VChd0H0zFC5R8NcNo+TXA6BCdaSo="

#else
static let BASE_URL = URL(string: "https://api.foursquare.com/v3/")!
static let API_KEY = "fsq3uPDlRL0+L+hC4R4VChd0H0zFC5R8NcNo+TXA6BCdaSo="
#endif
}
