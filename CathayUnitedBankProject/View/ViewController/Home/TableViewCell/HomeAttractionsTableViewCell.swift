//
//  HomeAttractionsTableViewCell.swift
//  CathayUnitedBankProject
//
//  Created by Steven Lin on 2025/7/11.
//

import UIKit

class HomeAttractionsTableViewCell: BaseTableViewCell {
    private let titleLabel: UILabel = {
       let v = UILabel()
        v.font = .systemFont(ofSize: 20, weight: .bold)
        v.textColor = .white
        v.backgroundColor = .themeBackground
        v.layer.cornerRadius = 8
        v.clipsToBounds = true
        v.textAlignment = .center
        v.numberOfLines = 1
        
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    private let descriptionLabel: UILabel = {
       let v = UILabel()
        v.font = .systemFont(ofSize: 15, weight: .medium)
        v.textColor = .darkGray
        v.textAlignment = .center
        v.numberOfLines = 4
        v.lineBreakMode = .byTruncatingTail
        
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    private let briefImageView: UIImageView = {
       let v = UIImageView()
        v.contentMode = .scaleAspectFill
        v.layer.cornerRadius = 8
        v.clipsToBounds = true
        
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    private let backView: UIView = {
        let v = UIView()
        v.backgroundColor = .white
        v.layer.cornerRadius = 15
        v.clipsToBounds = true
        
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        titleLabel.text = ""
        descriptionLabel.text = ""
        briefImageView.image = nil
        briefImageView.backgroundColor = .gray
    }
    
    override func setupUI() {
        self.backgroundColor = .clear
        
        [titleLabel, descriptionLabel, briefImageView].forEach { [weak self] v in
            self?.backView.addSubview(v)
        }
        
        self.addSubview(backView)
        
        NSLayoutConstraint.activate([
            backView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            backView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            backView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            backView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),
            
            briefImageView.centerYAnchor.constraint(equalTo: backView.centerYAnchor),
            briefImageView.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 5),
            briefImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/3),
            briefImageView.heightAnchor.constraint(equalTo: briefImageView.widthAnchor, multiplier: 2/3),
            
            titleLabel.topAnchor.constraint(equalTo: backView.topAnchor, constant: 5),
            titleLabel.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -5),
            titleLabel.leadingAnchor.constraint(equalTo: briefImageView.trailingAnchor, constant: 5),
            titleLabel.heightAnchor.constraint(equalToConstant: 20),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            descriptionLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            descriptionLabel.bottomAnchor.constraint(equalTo: backView.bottomAnchor, constant: -5)
        ])
    }
    
    override func setCell(_ data: Any) {
        guard let data = data as? AttractionData else { return }
        let placeHolderImage = UIImage(resource: .mainLogo)
        titleLabel.text = data.name
        descriptionLabel.text = data.introduction
        if let src = data.images?.first?.src, let url = URL(string: src){
            briefImageView.kf.setImage(with: url, placeholder: placeHolderImage)
        }else {
            briefImageView.image = placeHolderImage
        }
    }
}
