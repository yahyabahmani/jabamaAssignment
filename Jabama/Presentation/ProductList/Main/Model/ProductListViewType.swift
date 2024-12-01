//
//  ProductListViewType.swift
//  Jabama
//
//  Created by Mohsen on 12/1/24.
//

enum ProductListViewType {
    case list
    case map
    
    var image: String {
        switch self {
        case .list: return "list.bullet"
        case .map: return "globe"
        }
    }
    
    var title: String {
        switch self {
        case .list: return "List"
        case .map: return "Map"
        }
    }
}
