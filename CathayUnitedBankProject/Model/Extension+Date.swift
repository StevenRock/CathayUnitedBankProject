//
//  Extension+Date.swift
//  CathayUnitedBankProject
//
//  Created by Steven Lin on 2025/7/10.
//

import Foundation

extension Date{
    func transToString()->String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: self)
    }
}
