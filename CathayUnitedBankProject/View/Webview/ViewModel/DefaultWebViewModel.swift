//
//  DefaultWebViewModel.swift
//  CathayUnitedBankProject
//
//  Created by Steven Lin Macmini on 2025/7/13.
//

import Foundation

protocol DefaultWebViewModelDelegate{
    var strUrlPublisher: Published<String>.Publisher { get }
    var titlePublisher: Published<String>.Publisher { get }
}

class DefaultWebViewModel: DefaultWebViewModelDelegate{
    @Published var strUrl: String
    @Published var title: String
    
    var strUrlPublisher: Published<String>.Publisher {$strUrl}
    var titlePublisher: Published<String>.Publisher {$title}
    
    init(url: String?, title: String){
        if let url = url{
            strUrl = url
        }else{
            strUrl = ""
        }
        
        self.title = title
    }
}

