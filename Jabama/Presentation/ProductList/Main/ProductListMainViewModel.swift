//
//  ProductListMainViewModel.swift
//  Jabama
//
//  Created by Mohsen on 12/1/24.
//

import Foundation

@Observable
class ProductListMainViewModel:BaseViewModel<ProductListEvent> {
    
    var searchText:String = ""
    
    
    override init() {
        super.init()
    }
    
    override func onEvent(_ event: ProductListEvent) {
        
    }
}
