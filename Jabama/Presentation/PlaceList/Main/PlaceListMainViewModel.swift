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
    
    private(set) var viewState:ViewState = .loading
    private(set) var places: [SearchPlace] = []
    private(set) var error:ErrorModel?
    
    var searchText:String = ""
    private(set) var viewType: PlaceListViewType = .list
    
    @ObservationIgnored
    private var currentLimit:Int = 10
    
    private(set) var canLoadMore:Bool = true
    
    
    override init() {
        super.init()
        Task{
            await fetchPlaces()
        }
    }
    
    override func onEvent(_ event: PlaceListEvent) {
        switch event {
        case .changeViewType:
            changeViewType()
        case .loadMore:
            Task{
                await fetchPlaces(currentLimit + 10,isSilent: true)
            }
            
        }
    }
}

extension PlaceListMainViewModel{
    
    private func changeViewType(){
        self.viewType = viewType == .list ? .map : .list
    }
    
    private func fetchPlaces(_ limit:Int = 10,isSilent:Bool = false) async{
        currentLimit = limit
        if !isSilent{
            viewState = .loading
        }
        error = nil
        let query = SearchPlaceQuery(query:searchText,limit: currentLimit)
        do{
            let res = try await apiService.searchPlaces(query: query).async()
            if let places = res.results, !places.isEmpty{
                self.places = places
                self.viewState = .idle
                if currentLimit >= 50{
                    canLoadMore = false
                }
            }else{
                self.canLoadMore = false
                if self.places.isEmpty{
                    self.viewState = .empty
                }
            }
        }catch{
            self.error = error.toModel()
            self.viewState = .error
        }
       
    }
}
