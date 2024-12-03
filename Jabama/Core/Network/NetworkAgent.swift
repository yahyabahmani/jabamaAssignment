//
//  NetworkAgent.swift
//  Boom
//
//  Created by Mohsen Mokhtari on 6/3/20.
//

import Foundation
import Combine

struct NetworkAgent {
    
    let networkReachability = NetworkReachability()
    func runReq<T: Codable>(_ request: URLRequest, isJson: Bool = true) -> AnyPublisher<T, ErrorModel> {
#if DEBUG
        NetworkUtil.logRequest(request: request)
#endif
        
        return URLSession.shared
            .dataTaskPublisher(for: request)
            .tryMap { data, response in
#if DEBUG
                NetworkUtil.logResponse(data: data, response: (response as? HTTPURLResponse), error: nil)
#endif
                
                guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                    if let httpResponse = response as? HTTPURLResponse {
#if DEBUG
                        print("Error Status Code => \(httpResponse.statusCode)")
#endif
                        if 401 == httpResponse.statusCode {
                            NSNotification.makeUnauthorized(isUnauthorized: true)
                            throw ErrorModel(code: 401,message: "Sorry, you are not authorized to access this resource.")
                        }
                        let errorRes = try? JSONDecoder().decode(ErrorModel.self, from: data)
                        throw errorRes ?? ErrorModel(code: 0,message: "Unknown Error")
                    }
                    if !networkReachability.reachable{
                        throw ErrorModel(code: 1000,message: "Please check your internet connection.")
                    }
                    
                    throw ErrorModel(code: 0,message: "Unknown Error")
                }
                return data
            }
            .decode(type:T.self, decoder: JSONDecoder())
            .mapError {
                if let error = $0 as? ErrorModel {
                    return error
                } else {
                    if !networkReachability.isConnected(){
                        return ErrorModel(code: 1000,message: "Please check your internet connection.")
                    }else{
                        return ErrorModel(code: 0,message: "Unknown Error")
                    }
                    
                }
                
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
        
    }
}
