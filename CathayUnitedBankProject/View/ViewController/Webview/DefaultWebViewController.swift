//
//  DefaultWebViewController.swift
//  CathayUnitedBankProject
//
//  Created by Steven Lin Macmini on 2025/7/13.
//

import Foundation
import WebKit
import SwiftUI

class DefaultWebViewController: BaseViewController{
    lazy var infoWebView: WKWebView = {
        let v = WKWebView(frame: .zero)
                
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    var viewModel: DefaultWebViewModelDelegate?{
        didSet{
            binding()
        }
    }
    
    var orbitView: UIView?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        runOrbit()
    }
    
    override func binding() {
        guard let viewModel = viewModel else { return }
        
        viewModel.strUrlPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] val in
                guard let val else{
                    print("get map URL failed")
                    return
                }
                self?.loadWeb(url: val)
            }.store(in: &cancellables)
        
        viewModel.titlePublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] val in
                self?.title = val
            }.store(in: &cancellables)
    }
    
    override func setupUI() {
        super.setupUI()
        
        self.view.addSubview(infoWebView)
        
        NSLayoutConstraint.activate([
            infoWebView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            infoWebView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            infoWebView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            infoWebView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func loadWeb(url: URL?){
        guard let url = url else { return }
        let req = URLRequest(url: url)
        infoWebView.navigationDelegate = self
        infoWebView.load(req)
    }
    private func runOrbit(){
        let hostVC = UIHostingController(rootView: JumpingOrbitView())
        let orbitView = hostVC.view!
        orbitView.translatesAutoresizingMaskIntoConstraints = false
        addChild(hostVC)
        
        view.addSubview(orbitView)
        
        NSLayoutConstraint.activate([
            orbitView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            orbitView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
        
        hostVC.didMove(toParent: self)
        
        self.orbitView = orbitView
    }
}

extension DefaultWebViewController: WKNavigationDelegate{
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        print("SceneInfoVC load web error: \(error.localizedDescription)")
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("SceneInfoVC load web start loading")
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("SceneInfoVC load web finish loading")
        
        orbitView?.removeFromSuperview()
    }
}

