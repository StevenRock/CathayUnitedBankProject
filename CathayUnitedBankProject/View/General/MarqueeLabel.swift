//
//  MarqueeLabel.swift
//  CathayUnitedBankProject
//
//  Created by Steven Lin on 2025/7/11.
//

import UIKit

class MarqueeLabel: UIView{
    var isInit: Bool = true
    var textLabel: UILabel?
    
    var text: String = ""{
        didSet{
            isInit = true
            textLabel?.removeFromSuperview()
            textLabel = nil
            setupUI(text: text)
        }
    }
    
    var font: UIFont = .systemFont(ofSize: 12){
        didSet{
            textLabel?.font = font
        }
    }
    
    var textColor: UIColor = .label{
        didSet{
            textLabel?.textColor = textColor
        }
    }
    
    private var speed: CGFloat = 0
        
    override init(frame: CGRect){
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(text: String){
        let label = addLabel()
        label.text = text
        
        self.backgroundColor = .clear
        self.addSubview(label)
        self.clipsToBounds = true
                
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: self.topAnchor),
            label.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            label.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
        
        textLabel = label
        
        textLabel?.layoutIfNeeded()
    }
    
    func addLabel() -> UILabel{
        let label = UILabel()
        label.font = font
        label.textColor = textColor
        label.textAlignment = .center
        label.numberOfLines = 1
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    func startMarquee(delay: TimeInterval = 3, speed: CGFloat = 0){
        if isInit{
            self.textLabel?.transform = CGAffineTransform(translationX: 0, y: 0)
        }
        
        self.speed = speed
        
        guard let textLabel, speed != 0, textLabel.bounds.width > self.bounds.width else {
            textLabel?.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
            return
        }
        
        let distance = textLabel.bounds.width
        let duration = TimeInterval(distance / speed)
                
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: duration, delay: delay, options: .curveEaseIn) {
            self.textLabel?.transform = CGAffineTransform(translationX: -textLabel.bounds.width, y: 0)
        } completion:{ _ in
            self.isInit = false
            self.textLabel?.transform = CGAffineTransform(translationX: self.bounds.width, y: 0)
            self.startMarquee(delay: 1, speed: speed)
        }
    }

}

