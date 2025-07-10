//
//  NetworkManager.swift
//  CathayUnitedBankProject
//
//  Created by Steven Lin on 2025/7/10.
//

import Foundation

enum ApiError: Error{
    case errorRes((code: Int, data: Data))
    case internalErr(Int)
}

actor NetworkManager{
    static let shared = NetworkManager()
    
    enum HTTPError: Error{
        case InvalidURL
        case NotOK(code: Int)
        case InvalidResponse
    }
    
    enum Method: String{
        case GET = "GET"
        case POST = "POST"
        case PUT = "PUT"
        case PATCH = "PATCH"
        case DELETE = "DELETE"
    }
    
    var session: URLSession{
        get{
            let config = URLSessionConfiguration.default
            config.timeoutIntervalForRequest = 30
            config.timeoutIntervalForResource = 60
            config.httpAdditionalHeaders = [
                "Accept": "application/json",
                "Content-Type": "application/json",
            ]
            
            return URLSession(configuration: config)
        }
    }
    
    private let severPrefix = "https://www.travel.taipei/open-api"
    
    func callApi<T: Codable>(method: Method, url: String, para: [String: Any]? = nil, returnType type: T.Type = Bool.self) async throws -> Result<T, ApiError>{
        var paraData: Data?
        if let para{
            paraData = try JSONSerialization.data(withJSONObject: para)
        }
        
        guard let req = buildRequest(url: url, method: method, data: paraData) else {
            throw HTTPError.InvalidURL
        }
        
        let (data, response) = try await session.data(for: req)
        if let res = response as? HTTPURLResponse, !(200...299 ~= res.statusCode){
            return .failure(.errorRes((code: res.statusCode, data: data)))
        }
        
        if type == Bool.self{
            return .success(true as! T)
        }
        
        if let rawData = try CommonDecoder.decodeFromData(decodeFrom: data, decodeType: type ){
            return .success(rawData)
        }
        
        throw HTTPError.InvalidResponse
    }
    
    private func buildRequest(url: String, method: Method, additionalHeaders: Dictionary<String, String>? = nil, data: Data? = nil) -> URLRequest?{
        let urlString = "\(severPrefix)/\(url)"
        
        guard let _url = URL(string: urlString) else { return nil }
        var req = URLRequest(url: _url)
        req.httpMethod = method.rawValue
        if let data = data{
            req.httpBody = data
        }
        
        if let headers = additionalHeaders{
            for (name, value) in headers{
                req.setValue(value, forHTTPHeaderField: name)
            }
        }
        
        return req
    }
    
}
