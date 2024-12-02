//
//  PlaceListMainViewModel.swift
//  Jabama
//
//  Created by Mohsen on 12/1/24.
//

import Foundation

@Observable
class PlaceListMainViewModel:BaseViewModel<PlaceListEvent> {
    @ObservationIgnored
    @Inject private var apiService:PlaceListApiService
    
    private(set) var viewState:ViewState = .idle
    private(set) var places: [SearchPlace] = []
    
    var searchText:String = ""
    private(set) var viewType: PlaceListViewType = .list
    
    @ObservationIgnored
    private var currentLimit:Int = 10
    
    
    override init() {
        super.init()
        Task{
            await searchPlaces()
        }
    }
    
    override func onEvent(_ event: PlaceListEvent) {
        switch event {
        case .changeViewType:
            changeViewType()
        }
    }
}

extension PlaceListMainViewModel{
    
    private func changeViewType(){
        self.viewType = viewType == .list ? .map : .list
    }
    
    private func searchPlaces() async{
        viewState = .loading
        let query = SearchPlaceQuery(query:searchText,limit: currentLimit)
        do{
            let res = try await apiService.searchPlaces(query: query).async()
            if let places = res.results{
                self.places = places
            }
        }catch{
            print(error)
        }
       
    }
}
