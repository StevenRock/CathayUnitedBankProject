//
//  HomeViewController.swift
//  CathayUnitedBankProject
//
//  Created by Steven Lin on 2025/7/10.
//

import UIKit

class HomeViewController: BaseViewController {
    
    private let homeTitleView: HomeTitleContainerView = {
        let v = HomeTitleContainerView()
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
        
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    private lazy var attractionsTableView: HomeTableViewContainerView = {
        let v = HomeTableViewContainerView<AttractionData>(cell: HomeAttractionsTableViewCell.self)
        
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    var newsTableViewConst: NSLayoutConstraint?
    var attractionTableViewConst: NSLayoutConstraint?
//    lazy var newsTableView: UITableView = {
//        let v = UITableView()
//        v.separatorStyle = .none
//        v.delegate = self
//        v.backgroundColor = .clear
////        v.tableHeaderView = headerView
//        v.register(AccountOptionTableViewCell.self, forCellReuseIdentifier: "cell")
//        v.translatesAutoresizingMaskIntoConstraints = false
//        return v
//    }()
//    
//    lazy var dataSource: UITableViewDiffableDataSource<DiffableSection, AttractionData> = {
//        return UITableViewDiffableDataSource(tableView: tableView) { tableView, indexPath, model -> AccountOptionTableViewCell? in
//            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? AccountOptionTableViewCell
//            cell?.setCell(model)
//            
//            return cell
//        }
//    }()
    
    var viewModel: HomeViewModelDelegate?{
        didSet{
            binding()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }

    override func setupUI() {
        self.view.backgroundColor = .themeBackground
        
        homeTitleView.frame = self.view.frame
        
        [newsTableView, attractionsTableView, segmentControl, homeTitleView].forEach { [weak self] v in
            guard let self else {return}
            self.view.addSubview(v)
        }
        
        let newsLeadingConst = newsTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor)
        let attractionsLeadingConst = attractionsTableView.leadingAnchor.constraint(equalTo: newsTableView.trailingAnchor)
        
        NSLayoutConstraint.activate([
            segmentControl.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100),
            segmentControl.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            segmentControl.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            
            newsTableView.topAnchor.constraint(equalTo: segmentControl.bottomAnchor),
            newsLeadingConst,
            newsTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            newsTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            
            attractionsTableView.topAnchor.constraint(equalTo: newsTableView.topAnchor),
            attractionsLeadingConst,
            attractionsTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
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
    }
    
    @objc func changeSegment(sender: UISegmentedControl){
        var offset: CGFloat = 0
        
        switch sender.selectedSegmentIndex{
        case 0:
            offset = 0
        case 1:
            offset = -self.view.bounds.width
        default:
            break
        }
        
        newsTableViewConst?.constant = offset
        attractionTableViewConst?.constant = offset
        
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.5, delay: 0) { [weak self] in
            self?.view.layoutIfNeeded()
        }
    }

}
