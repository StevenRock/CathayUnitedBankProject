//
//  HomeNewsTableViewCell.swift
//  CathayUnitedBankProject
//
//  Created by Steven Lin on 2025/7/11.
//

import UIKit

class HomeNewsTableViewCell: BaseTableViewCell{
    private let backView: UIView = {
        let v = UIView()
        v.backgroundColor = .white
        v.layer.cornerRadius = 15
        v.clipsToBounds = true
        
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    private let titleLabel: UILabel = {
        let v = UILabel()
        v.font = .boldSystemFont(ofSize: 25)
        v.textColor = .gray
        v.numberOfLines = 1
        v.lineBreakMode = .byTruncatingTail
        
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    private let descriptionLabel: UILabel = {
        let v = UILabel()
        v.font = .systemFont(ofSize: 15, weight: .medium)
        v.textColor = .gray
        v.numberOfLines = 3
        v.lineBreakMode = .byTruncatingTail
        
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    override func setupUI() {
        self.backgroundColor = .clear
        
        [backView, titleLabel, descriptionLabel].forEach { [weak self] v in
            self?.addSubview(v)
        }
        
        NSLayoutConstraint.activate([
            backView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            backView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            backView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            backView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),
            
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            titleLabel.heightAnchor.constraint(equalToConstant: 40),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            descriptionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            descriptionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            descriptionLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5)
            
        ])
    }
    
    override func setCell(_ data: Any) {
        guard let data = data as? NewsData else { return }
        
        titleLabel.text = data.title
        descriptionLabel.text = data.description
    }
}
