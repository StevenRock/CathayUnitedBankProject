//
//  MarqueeLabel.swift
//  CathayUnitedBankProject
//
//  Created by Steven Lin on 2025/7/11.
//

import UIKit

class MarqueeLabel: UIView{
    private let label: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .medium)
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 1
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    var text: String = ""{
        didSet{
            label.text = text
        }
    }
    
    var font: UIFont = .systemFont(ofSize: 12){
        didSet{
            label.font = font
        }
    }
    
    var textColor: UIColor = .label{
        didSet{
            label.textColor = textColor
        }
    }
    
    private var speed: CGFloat = 0
        
    override init(frame: CGRect){
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(){
        self.backgroundColor = .clear
        self.addSubview(label)
        self.clipsToBounds = true
                
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: self.topAnchor),
            label.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            label.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
    
    func startMarquee(delay: TimeInterval = 3, speed: CGFloat = 0){
        self.speed = speed
        
        guard speed != 0, label.bounds.width > self.bounds.width else {
            label.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
            return
        }
        
        let distance = label.bounds.width
        let duration = TimeInterval(distance / speed)
                
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: duration, delay: delay, options: .curveEaseIn) {
            self.label.transform = CGAffineTransform(translationX: -self.label.bounds.width, y: 0)
        } completion:{ _ in
            self.label.transform = CGAffineTransform(translationX: self.bounds.width, y: 0)
            self.startMarquee(delay: 1, speed: speed)
        }
    }

}

