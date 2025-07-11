//
//  BaseViewController.swift
//  CathayUnitedBankProject
//
//  Created by Steven Lin on 2025/7/11.
//

import UIKit
import Combine

class BaseViewController: UIViewController{
//    var loadingView: LoadingView?
    
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
        
        self.navigationController?.setNavigationBarHidden(isNavHidden, animated: true)
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
    
//    func setupLoadingView(){
//        DispatchQueue.main.async {
//            let v = LoadingView(frame: CGRect(origin: .zero,
//                                              size: CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)))
////            v.translatesAutoresizingMaskIntoConstraints = false
//            if self.isNavHidden && !self.isTabbarHidden{
//                self.tabBarController?.view.addSubview(v)
//            }else if !self.isNavHidden{
//                self.navigationController?.navigationBar.addSubview(v)
//            }else{
//                self.view.addSubview(v)
//            }
//            
//            self.loadingView = v
//            v.play()
//        }
//    }
//    
//    func removeLoading(){
//        DispatchQueue.main.async {
//            self.loadingView?.stop()
//            self.loadingView?.removeFromSuperview()
//        }
//    }
    
    func setNavigationRightButton(button: UIButton){
        let rightBarItem = UIBarButtonItem(customView: button)
        
        if self.navigationItem.rightBarButtonItems != nil{
            self.navigationItem.rightBarButtonItems?.append(rightBarItem)
        }else{
            self.navigationItem.rightBarButtonItems = [rightBarItem]
        }
    }
}

