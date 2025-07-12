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
    
    var cellDidSelected: ((T) -> Void)?
    var tableViewDidScroll: ((Bool)->Void)?
    var lastContentOffset: CGFloat = 0
    
    let cellType: UITableViewCell.Type
    
    
    init(cell: UITableViewCell.Type){
        self.cellType = cell
        
        super.init(frame: .zero)
        
        tableView.delegate = self
        tableView.register(cell, forCellReuseIdentifier: "cell")
        
        dataSource = UITableViewDiffableDataSource<DiffableSection, T>(tableView: tableView) { tableView, indexPath, model in
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? BaseTableViewCell
            cell?.setCell(model)
            return cell
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupUI() {
        self.backgroundColor = .clear
        self.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    func setSnapShot(data: [T]){
        var snapShot = NSDiffableDataSourceSnapshot<DiffableSection, T>()
        snapShot.appendSections([.main])
        snapShot.appendItems(data)

        self.dataSource.apply(snapShot, animatingDifferences: true)
    }
    
    //UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let selectedItem = dataSource.itemIdentifier(for: indexPath) else { return }
        
        self.cellDidSelected?(selectedItem)
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


