//
//  CommonDecoder.swift
//  CathayUnitedBankProject
//
//  Created by Steven Lin on 2025/7/10.
//

import Foundation

class CommonDecoder{
    class func decodeFromData<T>(decodeFrom data: Data, decodeType: T.Type, dateFormat: String? = nil) throws -> T? where T : Codable {
        let jsonDecoder = JSONDecoder()
        
        if let dateFormat = dateFormat {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = dateFormat
            jsonDecoder.dateDecodingStrategy = .formatted(dateFormatter)
        }
        
        do {
            let result = try jsonDecoder.decode(decodeType, from: data)
            return result
        } catch {
            print("decodeFromData catch error:", error.localizedDescription)
            return nil
        }
    }
}
