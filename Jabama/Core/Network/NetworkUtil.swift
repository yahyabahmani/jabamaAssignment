//
// Created by Mohsen Mokhtari on 6/9/20.
//

import Foundation
import UIKit

struct NetworkUtil {
    private let base = Constants.BASE_URL

    static func getApiUrl(of apiAddress: String) -> URL {
        Constants.BASE_URL.appendingPathComponent(apiAddress)
    }

    static func logRequest(request: URLRequest?) {
        if let request = request {
            let urlString = request.url?.absoluteString ?? ""
            let components = NSURLComponents(string: urlString)

            let method = request.httpMethod != nil ? "\(request.httpMethod!)" : ""
            let path = "\(components?.path ?? "")"
            let query = "\(components?.query ?? "")"
            let host = "\(components?.host ?? "")"

            var requestLog = "\n---------- OUT ---------->\n"
            requestLog += "\(urlString)"
            requestLog += "\n\n"
            requestLog += "\(method) \(path)?\(query) HTTP/1.1\n"
            requestLog += "Host: \(host)\n"
            for (key, value) in request.allHTTPHeaderFields ?? [:] {
                requestLog += "\(key): \(value)\n"
            }
            if let body = request.httpBody {
                let bodyString = NSString(data: body, encoding: String.Encoding.utf8.rawValue) ?? "Can't render body; not utf8 encoded";
                requestLog += "\n\(bodyString)\n"
            }

            requestLog += "\n------------------------->\n";
            print(requestLog)
        } else {
            print("Request is Null")
        }
    }

    static func logResponse(data: Data?, response: HTTPURLResponse?, error: Error?) {

        let urlString = response?.url?.absoluteString
        let components = NSURLComponents(string: urlString ?? "")

        let path = "\(components?.path ?? "")"
        let query = "\(components?.query ?? "")"

        var responseLog = "\n<---------- IN ----------\n"
        if let urlString = urlString {
            responseLog += "\(urlString)"
            responseLog += "\n\n"
        }

        if let statusCode = response?.statusCode {
            responseLog += "HTTP \(statusCode) \(path)?\(query)\n"
        }
        if let host = components?.host {
            responseLog += "Host: \(host)\n"
        }
        for (key, value) in response?.allHeaderFields ?? [:] {
            responseLog += "\(key): \(value)\n"
        }
        if let body = data {
            let bodyString = NSString(data: body.subdata(in: 0..<min(5 * 1024, body.count)), encoding: String.Encoding.utf8.rawValue) ?? "Can't render body; not utf8 encoded";
            responseLog += "\n\(bodyString)\n"
        }
        if let error = error {
            responseLog += "\nError: \(error.localizedDescription)\n"
        }

        responseLog += "<------------------------\n";
        print(responseLog)
    }
    
    
    static func createUploadBody(filePathKey: String, data: Data, boundary: String) -> Data {
        var body = Data()

            let filename = "file"
            let mimetype = "image/jpeg"

            body.append(NSString(string: "--\(boundary)\r\n").data(using: String.Encoding.utf8.rawValue)!)
            body.append(NSString(string: "Content-Disposition: form-data; name=\"\(filePathKey)\"; filename=\"\(filename)\"\r\n").data(using: String.Encoding.utf8.rawValue)!)
            body.append(NSString(string: "Content-Type: \(mimetype)\r\n\r\n").data(using: String.Encoding.utf8.rawValue)!)
            body.append(data)
            body.append(NSString(string: "\r\n").data(using: String.Encoding.utf8.rawValue)!)
        

        body.append(NSString(string: "--\(boundary)--\r\n").data(using: String.Encoding.utf8.rawValue)!)
        return body
    }
    
    static func convertFileData(fieldName: String, fileName: String, mimeType: String = "", fileData: Data? = nil, using boundary: String = "Boundary-\(UUID().uuidString)") -> Data {
      let data = NSMutableData()

      data.appendString("--\(boundary)\r\n")
      data.appendString("Content-Disposition: form-data; name=\"\(fieldName)\"; filename=\"\(fileName)\"\r\n")
      data.appendString("Content-Type: \(mimeType)\r\n\r\n")
        if let fileData = fileData {
            data.append(fileData)
        }
      data.appendString("\r\n")

      return data as Data
    }

    

   

    static func generateBoundaryString() -> String {
        return "Boundary-\(UUID().uuidString)"
    }


    
}

extension URLComponents {
    var request: URLRequest? {
        url.map {
            URLRequest.init(url: $0)
        }
    }

}

extension NSMutableData {
  func appendString(_ string: String) {
    if let data = string.data(using: .utf8) {
      self.append(data)
    }
  }
}
