//
//  BaseViewController.swift
//  CathayUnitedBankProject
//
//  Created by Steven Lin on 2025/7/11.
//

import UIKit
import Combine

class BaseViewController: UIViewController{
    var goingForward: Bool = false
    
    var isNavHidden: Bool = false
    var isTabbarHidden: Bool = false
    var dismissAction: (()-> Void)?
    
    var isEnterBackground: Bool = false
    
    var cancellables: Set<AnyCancellable> = []
    
    override var shouldAutorotate: Bool{
        return false
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
        return .portrait
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.backButtonTitle = ""

        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(isNavHidden, animated: false)
        self.tabBarController?.tabBar.isHidden = isTabbarHidden
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    func setupUI(){
        self.view.backgroundColor = .white
    }
    
    func binding(){
        
    }
}

