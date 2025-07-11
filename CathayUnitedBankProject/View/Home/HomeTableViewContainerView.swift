//
//  HomeTableViewContainerView.swift
//  CathayUnitedBankProject
//
//  Created by Steven Lin on 2025/7/11.
//

import UIKit

class HomeTableViewContainerView<T: Hashable>: BaseView, UITableViewDelegate {
    private let tableView: UITableView = {
        let v = UITableView()
        v.separatorStyle = .none
        v.backgroundColor = .clear
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    var dataSource: UITableViewDiffableDataSource<DiffableSection, T>!
//    private lazy var dataSource: UITableViewDiffableDataSource<DiffableSection, T> = {
//        return UITableViewDiffableDataSource(tableView: tableView) { tableView, indexPath, model -> cellType.self? in
//            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? HomeNewsTableViewCell
//            cell?.setCell(model)
//            
//            return cell
//        }
//    }()
    
    var cellDidSelected: ((NewsData) -> Void)?
    var tableViewDidScroll: ((Bool)->Void)?
    var lastContentOffset: CGFloat = 0
    
    let cellType: UITableViewCell.Type
    
    let color: UIColor
    
    init(cell: UITableViewCell.Type, color: UIColor){
        self.cellType = cell
        self.color = color
        
        
        super.init(frame: .zero)
        
        tableView.delegate = self
        tableView.register(cell, forCellReuseIdentifier: "cell")
        
        dataSource = UITableViewDiffableDataSource<DiffableSection, T>(tableView: tableView) { tableView, indexPath, model in
              let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? HomeNewsTableViewCell
            cell?.setCell(model)
              return cell
           }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupUI() {
        self.backgroundColor = color
    }
    
    func setSnapShot(data: [T]){
        var snapShot = NSDiffableDataSourceSnapshot<DiffableSection, T>()
        snapShot.appendSections([.main])
        snapShot.appendItems(data)

        self.dataSource.apply(snapShot, animatingDifferences: true)
    }
    
    //UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let vc = AccountOption.allCases[indexPath.row].viewController
//
//        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.lastContentOffset = scrollView.contentOffset.y
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if self.lastContentOffset < scrollView.contentOffset.y {
            tableViewDidScroll?(true)
        } else if self.lastContentOffset > scrollView.contentOffset.y {
            tableViewDidScroll?(false)
        }
    }
}

//extension HomeTableViewContainerView: UITableViewDelegate where T: UITableViewCell{
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
////        let vc = AccountOption.allCases[indexPath.row].viewController
////        
////        self.navigationController?.pushViewController(vc, animated: true)
//    }
//    
//    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
//        self.lastContentOffset = scrollView.contentOffset.y
//    }
//    
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        if self.lastContentOffset < scrollView.contentOffset.y {
//            tableViewDidScroll?(true)
//        } else if self.lastContentOffset > scrollView.contentOffset.y {
//            tableViewDidScroll?(false)
//        }
//    }
//}
