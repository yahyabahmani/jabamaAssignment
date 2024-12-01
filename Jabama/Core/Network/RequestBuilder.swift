//
//  RequestBuilder.swift
//  Ludo
//
//  Created by mohsen mokhtari on 9/14/23.
//

import Foundation

class RequestBuilder {
    private(set) var baseURL: URL = AppConstants.BASE_URL
    private(set) var endpoint: String = ""
    private(set) var method: HttpMethod = .get
    private(set) var headers: [String: String] = [:]
    private(set) var parameters: [String: Any] = [:]
    private(set) var body: Data? = nil
    private(set) var fullUrl:String? = nil
    private(set) var isQueryDisabled: Bool = false






    public func setBaseUrl(_ url: URL = AppConstants.BASE_URL) -> RequestBuilder {
        self.baseURL = url
        return self
    }
    public func setEndpoint(_ value: String)-> RequestBuilder {
        self.endpoint = value
        return self
        
    }
    public func setMethod(_ value: HttpMethod)-> RequestBuilder  {
        self.method = value
        return self
    }
    public func addHeader(_ key: String, _ value: String)-> RequestBuilder  {
        self.headers[key] = value
        return self
    }
    public func addParameter(_ key: String, _ value: String)-> RequestBuilder  {
        self.parameters[key] = value
        return self
    }
    public func addParameter(_ key: String, _ value: Bool)-> RequestBuilder  {
        self.parameters[key] = value
        return self
    }
    public func addParameter(_ key: String, _ value: Int)-> RequestBuilder  {
        self.parameters[key] = value
        return self
    }
    public func setBody(_ value: Data?)-> RequestBuilder  {
        self.body = value
        return self
    }
    
    public func setFullUrl(_ value: String?)-> RequestBuilder  {
        self.fullUrl = value
        return self
    }
    
    public func disableQuery()-> RequestBuilder  {
        self.isQueryDisabled = true
        return self
    }

    
    
    
    

    public func build() -> URLRequest {
        var url:URL? = nil
        if fullUrl == nil
        {
             url = baseURL.appendingPathComponent(endpoint)
        }else{
            url = URL(string: fullUrl!)!
        }

        var component = URLComponents.init(url: url!, resolvingAgainstBaseURL: true)
        if !isQueryDisabled{
            component?.setQueryItems(with: parameters)
        }
        

        var urlRequest = URLRequest(url: component!.url!)
        urlRequest.httpMethod = method.rawValue
        if body != nil {
            urlRequest.httpBody = body
        }
       // add token header
        if !AppConstants.API_KEY.isEmpty{
            headers["Authorization"] = AppConstants.API_KEY
        }
        for header in headers {
            urlRequest.addValue(header.value, forHTTPHeaderField: header.key)
        }

        return urlRequest
    }
}

