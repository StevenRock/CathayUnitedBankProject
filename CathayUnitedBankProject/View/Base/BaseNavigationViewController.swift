//
//  BaseNavigationViewController.swift
//  CathayUnitedBankProject
//
//  Created by Steven Lin Macmini on 2025/7/13.
//

import UIKit

class BaseNavigationViewController: UINavigationController {

    override var shouldAutorotate: Bool{
        return true
    }
    
//    override init(rootViewController: UIViewController) {
//        super.init(navigationBarClass: BaseNavigationBar.self, toolbarClass: nil)
//        
//        self.viewControllers = [rootViewController]
//    }
    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupStyle()
    }
    
    
    private func setupStyle(){
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .themeBackground
        appearance.shadowColor = nil
        appearance.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: .semibold)
        ]
        let image = UIImage(resource: .backArrow).withRenderingMode(.alwaysOriginal)
        appearance.setBackIndicatorImage(image, transitionMaskImage: image)
        self.navigationBar.scrollEdgeAppearance = appearance
        self.navigationBar.standardAppearance = appearance
        self.navigationBar.compactAppearance = appearance
        self.navigationBar.compactScrollEdgeAppearance = appearance
    }
}

