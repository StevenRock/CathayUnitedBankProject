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
    
//    lazy var segmentControl: UISegmentedControl = {
//        let v = UISegmentedControl(items: [itemsUrls.first!.title, itemsUrls.last!.title])
//        v.backgroundColor = .clear
//        v.tintColor = .white
//        v.addTarget(self, action: #selector(changeUrl), for: .valueChanged)
//        v.translatesAutoresizingMaskIntoConstraints = false
//        return v
//    }()
    
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
    
    private var viewModel: HomeViewModel?{
        didSet{
            binding()
            
            let v = HomeTableViewContainerView<NewsData>(cell: HomeNewsTableViewCell.self, color: .red)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }

    override func setupUI() {
        self.view.backgroundColor = .white
        
        homeTitleView.frame = self.view.frame
        
        self.view.addSubview(homeTitleView)
    }
    
    override func binding() {
//        viewModel?.accountOptionsPublisher
//            .receive(on: DispatchQueue.main)
//            .sink(receiveValue: { [weak self] val in
//                var snapShot = NSDiffableDataSourceSnapshot<DiffableSection, AccountOption>()
//                snapShot.appendSections([.main])
//                snapShot.appendItems(val)
//                
//                self?.dataSource.apply(snapShot, animatingDifferences: true)
//            })
//            .store(in: &cancellables)
//        
//        viewModel?.memberBriefPublisher
//            .receive(on: DispatchQueue.main)
//            .sink(receiveValue: { [weak self] val in
//                if let val = val{
//                    self?.headerView.setData(title: val.name, id: val.uid)
//                }
//            })
//            .store(in: &cancellables)
    }

}

extension HomeViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let vc = AccountOption.allCases[indexPath.row].viewController
        
//        self.navigationController?.pushViewController(vc, animated: true)
    }
    
//    @objc func headerDidTap(){
//        guard let viewModel = viewModel else { return }
//        let vc = AccountMemberInfoViewController(memberInfo: viewModel.memberInfo)
//        
//        self.navigationController?.pushViewController(vc, animated: true)
//    }
}

