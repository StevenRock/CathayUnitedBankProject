//
//  HomeViewController.swift
//  CathayUnitedBankProject
//
//  Created by Steven Lin on 2025/7/10.
//

import UIKit

class HomeViewController: BaseViewController {
    
    private lazy var homeTitleView: HomeTitleContainerView = {
        let v = HomeTitleContainerView()
        v.languageDidChoosed = viewModel?.selectLanguage
        return v
    }()
    
    lazy var segmentControl: UISegmentedControl = {
        let v = UISegmentedControl(items: ["最新消息", "旅遊景點"])
        v.backgroundColor = .clear
        v.tintColor = .white
        v.addTarget(self, action: #selector(changeSegment), for: .valueChanged)
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    private lazy var newsTableView: HomeTableViewContainerView = {
        let v = HomeTableViewContainerView<NewsData>(cell: HomeNewsTableViewCell.self)
        v.cellDidSelected = { [weak self] val in
            self?.viewModel?.getSelectedNewsData(val)
        }
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    private lazy var attractionsTableView: HomeTableViewContainerView = {
        let v = HomeTableViewContainerView<AttractionData>(cell: HomeAttractionsTableViewCell.self)
        v.cellDidSelected = { [weak self] val in
            self?.viewModel?.getSelectedAttractionData(val)
        }
        
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    var newsTableViewConst: NSLayoutConstraint?
    var attractionTableViewConst: NSLayoutConstraint?
    
    var viewModel: HomeViewModelDelegate?{
        didSet{
            binding()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        isNavHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        segmentControl.selectedSegmentIndex = 0
    }

    override func setupUI() {
        self.view.backgroundColor = .themeBackground
        
        homeTitleView.frame = self.view.frame
        
        [newsTableView, attractionsTableView, segmentControl, homeTitleView].forEach { [weak self] v in
            guard let self else {return}
            self.view.addSubview(v)
        }
        
        let newsLeadingConst = newsTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor)
        let attractionsLeadingConst = attractionsTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: self.view.bounds.width)
        
        NSLayoutConstraint.activate([
            segmentControl.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100),
            segmentControl.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            segmentControl.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            
            newsTableView.topAnchor.constraint(equalTo: segmentControl.bottomAnchor),
            newsLeadingConst,
            newsTableView.widthAnchor.constraint(equalTo: self.view.widthAnchor),
            newsTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            
            attractionsTableView.topAnchor.constraint(equalTo: newsTableView.topAnchor),
            attractionsLeadingConst,
            attractionsTableView.widthAnchor.constraint(equalTo: self.view.widthAnchor),
            attractionsTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        
        newsTableViewConst = newsLeadingConst
        attractionTableViewConst = attractionsLeadingConst
    }
    
    override func binding() {
        viewModel?.newsListPublisher
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] val in
                self?.newsTableView.setSnapShot(data: val)

            })
            .store(in: &cancellables)
//        
        viewModel?.attractionsListPublisher
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] val in
                self?.attractionsTableView.setSnapShot(data: val)
            })
            .store(in: &cancellables)
        
        viewModel?.urlPublisher
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] val in
                guard let val else { return }
                let vc = DefaultWebViewController()
                vc.url = val
                vc.titleVal = "最新消息"
                self?.navigationController?.pushViewController(vc, animated: true)
                
            })
            .store(in: &cancellables)
    }
    
    
    
    func goWeb(_ data: NewsData){
        
    }
    
    @objc func changeSegment(sender: UISegmentedControl){
        var newsOffset: CGFloat = 0
        var attractionOffet: CGFloat = 0
        
        let w = self.view.bounds.width
        
        newsOffset = (sender.selectedSegmentIndex == 0) ? 0 : -self.view.bounds.width
        
        attractionOffet = (sender.selectedSegmentIndex == 1) ? 0 : w
        
        newsTableViewConst?.constant = newsOffset
        attractionTableViewConst?.constant = attractionOffet
        
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.5, delay: 0) { [weak self] in
            self?.view.layoutIfNeeded()
        }
    }

}
