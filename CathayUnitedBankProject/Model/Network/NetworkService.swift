//
//  NetworkService.swift
//  CathayUnitedBankProject
//
//  Created by Steven Lin on 2025/7/10.
//

import Foundation

class NetworkService {
    static let shared = NetworkService()
    
    private var language: Language{
        get{
            return LanguageManager.shared.lang
        }
    }
    
    func getAllAttractions(categoryId: Int? = nil, nLatitude: Double? = nil, eLongitude: Double? = nil, page: Int? = nil) async throws -> [AttractionData]{
        var dict:[String: Any] = [:]
        
        if let categoryId{
            dict["categoryIds"] = categoryId
        }
        
        if let nLatitude{
            dict["nlat"] = nLatitude
        }
        if let eLongitude{
            dict["elong"] = eLongitude
        }
        
        if let page{
            dict["page"] = page
        }
        
        let para = parameterForAPI(dict: dict)
        
        do{
            let res = try await NetworkManager.shared.callApi(method: .GET, url: "\(language)/\(kAllAttractions)\(para)", returnType: Attractions.self)
            switch res{
            case .success(let data):
                return data.data
            case .failure(ApiError.errorRes(let errRes)):
                throw NetworkManager.HTTPError.NotOK(code: errRes.code)
            case .failure(.internalErr(_)):
                throw NetworkManager.HTTPError.NotOK(code: 400)
            }
        }catch let err{
            print("get Attractions error", err.localizedDescription)
            throw NetworkManager.HTTPError.NotOK(code: 400)
        }
    }
    
    func getNews(begin: Date? = nil, end: Date? = nil, page: Int? = nil) async throws -> [NewsData]{
        var dict:[String: Any] = [:]
        
        if let begin{
            let str = begin.transToString()
            dict["begin"] = str
        }
        
        if let end{
            let str = end.transToString()
            dict["end"] = str
        }

        if let page{
            dict["page"] = page
        }
        
        let para = parameterForAPI(dict: dict)
        
        do{
            let res = try await NetworkManager.shared.callApi(method: .GET, url: "\(language)/\(kEvent)\(para)", returnType: News.self)
            switch res{
            case .success(let data):
                return data.data
            case .failure(ApiError.errorRes(let errRes)):
                throw NetworkManager.HTTPError.NotOK(code: errRes.code)
            case .failure(.internalErr(_)):
                throw NetworkManager.HTTPError.NotOK(code: 400)
            }
        }catch let err{
            print("get News error", err.localizedDescription)
            throw NetworkManager.HTTPError.NotOK(code: 400)
        }
    }
    
    private func parameterForAPI(dict: [String : Any]) -> String{
        var arr = [String]()
        for (key, val) in dict{
            arr.append(("\(key)=\(val)"))
        }
        
        if arr.isEmpty{
            return ""
        }
        
        let para = arr.joined(separator: "&")
        return "?\(para)"
    }
}
