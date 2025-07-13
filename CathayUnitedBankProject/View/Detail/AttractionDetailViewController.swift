//
//  AttractionDetailViewController.swift
//  CathayUnitedBankProject
//
//  Created by Steven Lin Macmini on 2025/7/14.
//

import UIKit

class AttractionDetailViewController: BaseViewController{
    lazy var scrollView: UIScrollView = {
        let v = UIScrollView()
        
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    lazy var slideshowView: SlideshowView = {
       let v = SlideshowView()
//        v.bannerDidTapped = {
//            self.bannerDidTapped?($0)
//        }
        
        v.translatesAutoresizingMaskIntoConstraints = false
        
        return v
    }()
    
    lazy var timeLabel: UILabel = {
       let v = UILabel()
        v.font = .boldSystemFont(ofSize: 20)
        v.textColor = .white
        v.textAlignment = .center
        v.numberOfLines = 1
        
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    lazy var telLabel: UILabel = {
       let v = UILabel()
        v.font = .boldSystemFont(ofSize: 15)
        v.textColor = .white
        v.textAlignment = .center
        v.numberOfLines = 1
        
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    lazy var webLabel: UILabel = {
       let v = UILabel()
        v.font = .boldSystemFont(ofSize: 15)
        v.textColor = .white
        v.textAlignment = .center
        v.numberOfLines = 1
        
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    lazy var descriptionLabel: UILabel = {
       let v = UILabel()
        v.font = .boldSystemFont(ofSize: 15)
        v.textColor = .white
        v.textAlignment = .center
        v.numberOfLines = 0
        
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    lazy var addressLabel: UILabel = {
       let v = UILabel()
        v.font = .boldSystemFont(ofSize: 15)
        v.textColor = .white
        v.textAlignment = .center
        v.numberOfLines = 1
        
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()

    override func setupUI() {
        [slideshowView, timeLabel, addressLabel, telLabel, webLabel, descriptionLabel].forEach { v in
            scrollView.addSubview(v)
        }
        
        self.view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            
        ])
    }
}
