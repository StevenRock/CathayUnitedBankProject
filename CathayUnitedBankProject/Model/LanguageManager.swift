//
//  LanguageManager.swift
//  CathayUnitedBankProject
//
//  Created by Steven Lin on 2025/7/10.
//

import Foundation

enum Language: String, CaseIterable{
    case taiwan = "zh-tw"
    case china = "zh-cn"
    case english = "en"
    case japan = "ja"
    case korea = "ko"
    
    case español = "es"
    case indonesia = "id"
    case thailand = "th"
    case vietnam = "vi"
}

class LanguageManager{
    static let shared = LanguageManager()
    var lang: Language
    
    private init(){
        lang = .taiwan
    }
    
    func setLang(_ lang: Language? = nil){
        if let lang{
            self.lang = lang
        }else{
            self.lang = .taiwan
        }
    }
}
