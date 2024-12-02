//
//  PlaceListMainViewModel.swift
//  Jabama
//
//  Created by Mohsen on 12/1/24.
//

import Foundation
import Combine

@Observable
class PlaceListMainViewModel:BaseViewModel<PlaceListEvent> {
    @ObservationIgnored
    @Inject private var apiService:PlaceListApiService
    
    private(set) var viewState:ViewState = .loading
    private(set) var places: [SearchPlace] = []
    private(set) var error:ErrorModel?
    
    
    private(set) var viewType: PlaceListViewType = .list
    
    @ObservationIgnored
    private var currentLimit:Int = 10
    
    private(set) var canLoadMore:Bool = true
    
    @ObservationIgnored
    private let searchTextPublisher = PassthroughSubject<String, Never>()
    
    @ObservationIgnored
    var searchText:String = ""
    
    @ObservationIgnored
    var cancellables = Set<AnyCancellable>()
    
    override init() {
        super.init()
        
        Task{
            await fetchPlaces()
        }
        
        listenToQueryChanges()
    }
    
    deinit{
        
    }
    
    override func onEvent(_ event: PlaceListEvent) {
        switch event {
        case .changeViewType:
            changeViewType()
        case .loadMore:
            Task{
                await fetchPlaces(currentLimit + 10,isSilent: true)
            }
        case .onSearchTextChanged(let query):
            onSearchTextChanged(query)
            
        }
    }
}

extension PlaceListMainViewModel{
    
    private func onSearchTextChanged(_ query:String){
        self.canLoadMore = true
        if !query.isEmpty{
            self.searchTextPublisher.send(query)
        }else if !searchText.isEmpty{
            self.searchTextPublisher.send("")
        }
    }
    
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
                self.viewState = .empty
                self.places.removeAll()
            }
        }catch{
            self.error = error.toModel()
            self.viewState = .error
        }
        
    }
    
    private func listenToQueryChanges(){
        searchTextPublisher
            .debounce(for: .seconds(0.2), scheduler: RunLoop.main)
            .sink { event in
                self.searchText = event
                Task{
                    await self.fetchPlaces(isSilent: true)
                }
                print("\(event)")
            }
            .store(in: &cancellables)
    }
}
