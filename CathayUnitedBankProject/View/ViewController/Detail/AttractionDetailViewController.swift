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
        
        v.translatesAutoresizingMaskIntoConstraints = false
        
        return v
    }()
    
    lazy var timeLabel: UILabel = {
        let v = UILabel()
        v.font = .boldSystemFont(ofSize: 20)
        v.textColor = .darkGray
        v.textAlignment = .center
        v.numberOfLines = 2
        v.backgroundColor = .white
        v.layer.cornerRadius = 10
        v.clipsToBounds = true
        v.layer.borderWidth = 2
        v.layer.borderColor = UIColor.gray.cgColor
        
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    lazy var telLabel: UILabel = {
        let v = UILabel()
        v.font = .boldSystemFont(ofSize: 20)
        v.textColor = .darkGray
        v.textAlignment = .center
        v.numberOfLines = 2
        v.backgroundColor = .white
        v.layer.cornerRadius = 10
        v.clipsToBounds = true
        v.layer.borderWidth = 2
        v.layer.borderColor = UIColor.gray.cgColor
        
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    lazy var webButton: UIButton = {
        let v = UIButton()
        v.addTarget(self, action: #selector(buttonTap), for: .touchUpInside)
        v.setTitleColor(.systemBlue, for: .normal)
        v.titleLabel?.font = .boldSystemFont(ofSize: 20)
        v.titleLabel?.numberOfLines = 2
        v.titleLabel?.textAlignment = .center
        v.backgroundColor = .white
        v.layer.cornerRadius = 10
        v.clipsToBounds = true
        v.layer.borderWidth = 2
        v.layer.borderColor = UIColor.gray.cgColor
        
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    lazy var descriptionLabel: UILabel = {
        let v = UILabel()
        v.font = .boldSystemFont(ofSize: 25)
        v.textColor = .darkGray
        v.textAlignment = .center
        v.numberOfLines = 0
        v.backgroundColor = .white
        v.layer.cornerRadius = 10
        v.clipsToBounds = true
        v.layer.borderWidth = 2
        v.layer.borderColor = UIColor.gray.cgColor
        
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    lazy var addressLabel: UILabel = {
        let v = UILabel()
        v.font = .boldSystemFont(ofSize: 20)
        v.textColor = .darkGray
        v.textAlignment = .center
        v.numberOfLines = 2
        v.backgroundColor = .white
        v.layer.cornerRadius = 10
        v.clipsToBounds = true
        v.layer.borderWidth = 2
        v.layer.borderColor = UIColor.gray.cgColor
        
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    var viewModel: AttractionDetailViewModelDelegate?{
        didSet{
            binding()
        }
    }
        
    override func binding() {
        viewModel?.vcPublisher
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] val in
                guard let val else {return}
                
                self?.navigationController?.pushViewController(val, animated: true)
            })
            .store(in: &cancellables)
        
        viewModel?.namePublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] val in
                guard let self else{return}
                self.title = val
            }.store(in: &cancellables)
        
        viewModel?.timePublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] val in
                guard let self else{return}
                let time = (val == "") ? "-" : val
                
                self.timeLabel.text = "\(LanguageManager.shared.lang.businesshourTitle):\n\(time)"
            }.store(in: &cancellables)
        
        viewModel?.telPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] val in
                guard let self else{return}
                let tel = (val == "") ? "-" : val
                
                self.telLabel.text = "\(LanguageManager.shared.lang.businesshourTitle):\n\(tel)"
            }.store(in: &cancellables)
        
        viewModel?.addressPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] val in
                guard let self else{return}
                let address = (val == "") ? "-" : val
                
                self.addressLabel.text = "\(LanguageManager.shared.lang.addressTitle):\n\(address)"
            }.store(in: &cancellables)
        
        viewModel?.webPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] val in
                guard let self else{return}
                let web = "\(LanguageManager.shared.lang.webAddressTitle):\n\((val == "") ? "-" : val)"
                
                self.webButton.setTitle(web, for: .normal)
            }.store(in: &cancellables)
        
        viewModel?.descriptionPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] val in
                guard let self else{return}
                let description = (val == "") ? "-" : val
                
                self.descriptionLabel.text = description
            }.store(in: &cancellables)
        
        viewModel?.slidersPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] val in
                guard let self else{return}
                let urls = val.compactMap(\.0)
                slideshowView.source = urls
            }.store(in: &cancellables)
    }
    
    override func setupUI() {
        self.view.backgroundColor = .themeBackground
        
        [slideshowView, timeLabel, addressLabel, telLabel, webButton, descriptionLabel].forEach { v in
            scrollView.addSubview(v)
        }
        
        self.view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            slideshowView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            slideshowView.heightAnchor.constraint(equalToConstant: 190),
            slideshowView.widthAnchor.constraint(equalTo: self.view.widthAnchor),
            slideshowView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            
            timeLabel.topAnchor.constraint(equalTo: slideshowView.bottomAnchor, constant: 10),
            timeLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor),
            timeLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            
            addressLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 10),
            addressLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor),
            addressLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            
            telLabel.topAnchor.constraint(equalTo: addressLabel.bottomAnchor, constant: 10),
            telLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor),
            telLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            
            webButton.topAnchor.constraint(equalTo: telLabel.bottomAnchor, constant: 10),
            webButton.widthAnchor.constraint(equalTo: self.view.widthAnchor),
            webButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            
            descriptionLabel.topAnchor.constraint(equalTo: webButton.bottomAnchor, constant: 10),
            descriptionLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor),
            descriptionLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            descriptionLabel.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            scrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            scrollView.widthAnchor.constraint(equalTo: self.view.widthAnchor),
            scrollView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        
        slideshowView.layoutIfNeeded()
    }
    
    @objc func buttonTap(){
        viewModel?.goWeb()
    }
}
