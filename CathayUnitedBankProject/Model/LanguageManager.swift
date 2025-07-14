//
//  LanguageManager.swift
//  CathayUnitedBankProject
//
//  Created by Steven Lin on 2025/7/10.
//

import Foundation
import UIKit

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
    
    var title: String{
        switch self{
        case.taiwan: return "悠遊台北"
        case.china: return "悠游台北"
        case.english: return "Undiscoved Taipei"
        case.japan: return "まだ知られていない台北"
        case.korea: return "아직 알려지지 않은 타이베이"
        case.español: return "El Taipéi por Descubrir"
        case.indonesia: return "Taipei yang Belum Banyak Diketahui"
        case.thailand: return "ไทเปที่ยังรอการค้นพบ"
        case.vietnam: return "Đài Bắc - Viên ngọc chưa được khám phá"
        }
    }
    
    var newsTitle: String{
        switch self{
        case.taiwan, .china: return "最新消息"
        default: return "News"
        }
    }
    
    var attractionTitle: String{
        switch self{
        case.taiwan, .china: return "旅遊景點"
        default: return "Attraction"
        }
    }
    
    var businesshourTitle: String{
        switch self{
        case.taiwan, .china: return "營業時間"
        default: return "Business Hour"
        }
    }
    
    var addressTitle: String{
        switch self{
        case.taiwan, .china: return "地址"
        default: return "Address"
        }
    }
    
    var telTitle: String{
        switch self{
        case.taiwan, .china: return "電話"
        default: return "Tel"
        }
    }
    
    var webAddressTitle: String{
        switch self{
        case.taiwan, .china: return "網址"
        default: return "Web Address"
        }
    }
    
    var image: UIImage{
        switch self{
        case.taiwan: return UIImage(resource: .taiwan)
        case.china: return UIImage(resource: .china)
        case.english: return UIImage(resource: .america)
        case.japan: return UIImage(resource: .japan)
        case.korea: return UIImage(resource: .korea)
        case.español: return UIImage(resource: .spain)
        case.indonesia: return UIImage(resource: .indonesia)
        case.thailand: return UIImage(resource: .thailand)
        case.vietnam: return UIImage(resource: .vietnam)
        }
    }
}

class LanguageManager{
    static let shared = LanguageManager()
    var lang: Language
    
    private init(){
        lang = .taiwan
    }
    
    var title: String{
        return lang.title
    }
    
    var image: UIImage{
        return lang.image
    }
    
    func setLang(_ lang: Language? = nil, completion: @escaping ()->Void){
        if let lang{
            self.lang = lang
        }else{
            self.lang = .taiwan
        }
        
        completion()
    }
}
