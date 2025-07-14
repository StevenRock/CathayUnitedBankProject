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
        v.languageDidChoosed = { [weak self] val in
            self?.segmentControl.setTitle(val.newsTitle, forSegmentAt: 0)
            self?.segmentControl.setTitle(val.attractionTitle, forSegmentAt: 1)
            self?.viewModel?.selectLanguage(val)
        }
        return v
    }()
    
    lazy var segmentControl: UISegmentedControl = {
        let v = UISegmentedControl(items: [LanguageManager.shared.lang.newsTitle, LanguageManager.shared.lang.attractionTitle])
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
    var selectSegmentIndex: Int = 0
    
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
        segmentControl.selectedSegmentIndex = selectSegmentIndex
    }

    override func setupUI() {
        self.view.backgroundColor = .themeBackground
        
        homeTitleView.frame = self.view.frame
        
        [newsTableView, attractionsTableView, segmentControl, homeTitleView].forEach { [weak self] v in
            guard let self else {return}
            self.view.addSubview(v)
        }
        
        let newsLeadingConst = newsTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor)
        let attractionsLeadingConst = attractionsTableView.leadingAnchor.constraint(equalTo: self.newsTableView.trailingAnchor)
        
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
        viewModel?.vcPublisher
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] val in
                guard let val else {return}
                
                self?.navigationController?.pushViewController(val, animated: true)
            })
            .store(in: &cancellables)
        
        viewModel?.newsListPublisher
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] val in
                self?.newsTableView.setSnapShot(data: val)

            })
            .store(in: &cancellables)
        
        viewModel?.attractionsListPublisher
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] val in
                self?.attractionsTableView.setSnapShot(data: val)
            })
            .store(in: &cancellables)
    }
    
    @objc func changeSegment(sender: UISegmentedControl){
        var newsOffset: CGFloat = 0
        var attractionOffet: CGFloat = 0
        
        let w = self.view.bounds.width
        selectSegmentIndex = sender.selectedSegmentIndex
        
        newsOffset = (sender.selectedSegmentIndex == 0) ? 0 : -self.view.bounds.width
        
        attractionOffet = (sender.selectedSegmentIndex == 1) ? 0 : w
        
        newsTableViewConst?.constant = newsOffset
        attractionTableViewConst?.constant = attractionOffet
        
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.5, delay: 0) { [weak self] in
            self?.view.layoutIfNeeded()
        }
    }

}
