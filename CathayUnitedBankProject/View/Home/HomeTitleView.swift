//
//  HomeTitleView.swift
//  CathayUnitedBankProject
//
//  Created by Steven Lin on 2025/7/11.
//

import UIKit

class HomeTitleContainerView: BaseView {
    private let mainLogoImageView: UIImageView = {
        let v = UIImageView()
        v.contentMode = .scaleAspectFit
        v.image = UIImage(resource: .mainLogo)
        
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    private let smallLogoImageView: UIImageView = {
        let v = UIImageView()
        v.contentMode = .scaleAspectFit
        v.image = UIImage(resource: .smallLogo)
        
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    private let titleLabel: MarqueeLabel = {
        let v = MarqueeLabel()
        v.font = .boldSystemFont(ofSize: 25)
        v.textColor = .white
        
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    var smallLogoTopConst: NSLayoutConstraint?
    var smallLogoLeadConst: NSLayoutConstraint?
    var smallLofoBottomConst: NSLayoutConstraint?
    
    override func setupUI(){
        self.backgroundColor = .themeBackground
        
        titleLabel.text = LanguageManager.shared.title
        
        self.addSubview(mainLogoImageView)
        self.addSubview(smallLogoImageView)
        
        let smallTopConst = smallLogoImageView.topAnchor.constraint(equalTo: mainLogoImageView.topAnchor)
        let smallTrailingConst = smallLogoImageView.trailingAnchor.constraint(equalTo: mainLogoImageView.trailingAnchor)
        let smallBottomConst = smallLogoImageView.bottomAnchor.constraint(equalTo: mainLogoImageView.bottomAnchor)
                
        NSLayoutConstraint.activate([
            mainLogoImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            mainLogoImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            smallTopConst,
            smallTrailingConst,
            smallBottomConst,

            smallLogoImageView.widthAnchor.constraint(equalTo: smallLogoImageView.heightAnchor),

        ])
                
        smallLogoTopConst = smallTopConst
        smallLogoLeadConst = smallTrailingConst
        smallLofoBottomConst = smallBottomConst
    }
    
    override func didMoveToSuperview() {
        guard let superview else { return }
        
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.5, delay: 0) { [weak self] in
            guard let self else { return }
            
            self.mainLogoImageView.alpha = 0
            
            self.layer.backgroundColor? = UIColor.themeBackground.withAlphaComponent(0.7).cgColor
        } completion: { [weak self] _ in
            guard let self else { return }
            
            self.mainLogoImageView.removeFromSuperview()
            
            self.translatesAutoresizingMaskIntoConstraints = false
            
            self.smallLogoTopConst?.isActive = false
            self.smallLogoLeadConst?.isActive = false
            self.smallLofoBottomConst?.isActive = false
            
            self.addSubview(self.titleLabel)
            self.titleLabel.alpha = 0
            
            NSLayoutConstraint.activate([
                self.titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                self.titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),
                self.titleLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/3),
                self.titleLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1/2),
                
                self.smallLogoImageView.topAnchor.constraint(equalTo: self.titleLabel.topAnchor),
                self.smallLogoImageView.leadingAnchor.constraint(equalTo: self.titleLabel.trailingAnchor, constant: 5),
                self.smallLogoImageView.bottomAnchor.constraint(equalTo: self.titleLabel.bottomAnchor),
                
                self.topAnchor.constraint(equalTo: superview.topAnchor),
                self.leadingAnchor.constraint(equalTo: superview.leadingAnchor),
                self.trailingAnchor.constraint(equalTo: superview.trailingAnchor),
                self.heightAnchor.constraint(equalToConstant: 100)
            ])
            
            UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 1, delay: 0) {
                superview.layoutIfNeeded()
                
            } completion: { _ in
                self.titleLabel.startMarquee(speed: 50)
                UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.2, delay: 0) {
                    self.titleLabel.alpha = 1
                }
            }
        }
    }
}

    
    
