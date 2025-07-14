//
//  Coordinator.swift
//  CathayUnitedBankProject
//
//  Created by Steven Lin on 2025/7/14.
//

import Foundation
import UIKit

protocol CoordinatorDelegate{
    var viewController: BaseViewController? { get }
    var vcPublisher: Published<BaseViewController?>.Publisher {get}
}

class Coordinator{
    
    static let shared = Coordinator()
    
    func initFirstViewController() -> BaseViewController{
        let vc = HomeViewController()
        vc.viewModel = HomeViewModel()
        
        return vc
    }
    
    func prepareWebViewController(url: URL, title: String? = nil)->BaseViewController{
        let vc = DefaultWebViewController()
        let titleName = (title == nil) ? LanguageManager.shared.lang.newsTitle : title
        vc.viewModel = DefaultWebViewModel(url: url, title: titleName!)
        
        return vc
    }
    
    func prepareAttractionViewCOntroller(data: AttractionData)->BaseViewController{
        let vc = AttractionDetailViewController()
        vc.viewModel = AttractionDetailViewModel(data: data)
        
        return vc
    }
}
