//
//  PlaceListRepoImpl.swift
//  Jabama
//
//  Created by Mohsen on 12/2/24.
//

import Combine

struct PlaceListRepoImpl:PlaceListRepo{
    @Inject private var agent: NetworkAgent
    
    func searchPlaces(query: SearchPlaceQuery) -> AnyPublisher<SearchPlaceRes, ErrorModel> {
        let builder = RequestBuilder()
            .setEndpoint("places/search")
            .addParameters(query.dictionary() ?? [:])
            .setMethod(.get)
        
        return agent.runReq(builder.build())
    }
    
    
}
