//
//  ProductListMainViewModel.swift
//  Jabama
//
//  Created by Mohsen on 12/1/24.
//

import Foundation

@Observable
class ProductListMainViewModel:BaseViewModel<ProductListEvent> {
    @ObservationIgnored
    @Inject private var apiService:ProductListApiService
    
    var searchText:String = ""
    private(set) var viewType: ProductListViewType = .list
    
    @ObservationIgnored
    private var currentLimit:Int = 10
    
    
    override init() {
        super.init()
        Task{
            await searchProducts()
        }
    }
    
    override func onEvent(_ event: ProductListEvent) {
        switch event {
        case .changeViewType:
            changeViewType()
        }
    }
}

extension ProductListMainViewModel{
    
    private func changeViewType(){
        self.viewType = viewType == .list ? .map : .list
    }
    
    private func searchProducts() async{
        let query = SearchPlaceQuery(query:searchText,limit: currentLimit)
        do{
            let result = try await apiService.searchPlaces(query: query).async()
            if let products = result.results{
                
            }
        }catch{
            print(error)
        }
       
    }
}
