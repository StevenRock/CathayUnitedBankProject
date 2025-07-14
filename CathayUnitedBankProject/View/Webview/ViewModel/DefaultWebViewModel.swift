//
//  DefaultWebViewModel.swift
//  CathayUnitedBankProject
//
//  Created by Steven Lin Macmini on 2025/7/13.
//

import Foundation

protocol DefaultWebViewModelDelegate{
    var strUrlPublisher: Published<URL?>.Publisher { get }
    var titlePublisher: Published<String>.Publisher { get }
}

class DefaultWebViewModel: DefaultWebViewModelDelegate{
    @Published var url: URL?
    @Published var title: String
    
    var strUrlPublisher: Published<URL?>.Publisher {$url}
    var titlePublisher: Published<String>.Publisher {$title}
    
    init(url: URL?, title: String){
        if let url = url{
            self.url = url
        }else{
            self.url = nil
        }
        
        self.title = title
    }
}

