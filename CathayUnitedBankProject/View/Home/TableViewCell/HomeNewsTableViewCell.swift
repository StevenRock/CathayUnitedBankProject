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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        titleLabel.text = ""
        descriptionLabel.text = ""
    }
    
    override func setupUI() {
        self.backgroundColor = .clear
        
        [titleLabel, descriptionLabel].forEach { [weak self] v in
            self?.backView.addSubview(v)
        }
        
        self.addSubview(backView)
        
        NSLayoutConstraint.activate([
            backView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            backView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            backView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            backView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),
            
            titleLabel.topAnchor.constraint(equalTo: backView.topAnchor, constant: 5),
            titleLabel.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -5),
            titleLabel.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 5),
            titleLabel.heightAnchor.constraint(equalToConstant: 40),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            descriptionLabel.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -5),
            descriptionLabel.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 5),
            descriptionLabel.bottomAnchor.constraint(equalTo: backView.bottomAnchor, constant: -5)
            
        ])
    }
    
    override func setCell(_ data: Any) {
        guard let data = data as? NewsData else { return }
        
        titleLabel.text = data.title
        descriptionLabel.text = data.description
    }
}
