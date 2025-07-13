//
//  ExpandableButtonGroupView.swift
//  CathayUnitedBankProject
//
//  Created by Steven Lin Macmini on 2025/7/13.
//

import UIKit

class ExpandableButtonGroupView: UIView{
    private lazy var mainButton: UIButton = {
        let v = UIButton()
        v.setImage(UIImage(resource: .langIcon), for: .normal)
        v.contentMode = .scaleAspectFit
        v.addTarget(self, action: #selector(mainClicked), for: .touchUpInside)
        return v
    }()
    
    private var buttons: [UIButton] = []
    var buttonImages: [Language] = []
    
    private var delay: TimeInterval = 0
    private let delayOffset: TimeInterval = 0.05

    private var h: CGFloat = 0
    
    private var isExpand: Bool = false
    private var isExpanding: Bool = false
    
    var languageDidChoosed: ((Language) -> Void)?
    var dismiss:(()->Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        h = mainButton.bounds.height
        
        if !buttonImages.isEmpty{
            buttons.removeAll()
            for i in 0..<buttonImages.count{
                let btn = UIButton(frame: mainButton.bounds)
                btn.tag = i
                btn.setImage(buttonImages[i].image, for: .normal)
                btn.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
                btn.contentMode = .scaleAspectFit
                btn.isEnabled = true
                buttons.append(btn)
                
                self.insertSubview(btn, at: i)
                
                btn.alpha = 0
            }
        }
    }
    
    func setupUI(){
        self.backgroundColor = .clear
        mainButton.frame = self.bounds
        self.addSubview(mainButton)
        
        mainButton.layoutIfNeeded()
    }
    
    @objc func mainClicked(){
        guard !isExpanding else {
            return}
        
        isExpanding = true
        
        if !isExpand{
            mainButton.setImage(UIImage(resource: .langIcon), for: .normal)
        }
        
        self.frame = CGRect(origin: self.frame.origin,
                             size: CGSize(width: self.bounds.width, height: (isExpand) ? h : h * CGFloat(
                                          buttons.count+1)))
        
        buttons.enumerated().forEach { (ind, v) in
            let hOffset = h * CGFloat((ind + 1))
            
            UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.5, delay: 0){
                v.alpha = (self.isExpand) ? 0 : 1
            }
            
            UIViewPropertyAnimator.runningPropertyAnimator(withDuration: delay, delay: 0){
                v.transform = CGAffineTransform(translationX: 0, y: (self.isExpand) ? 0 : hOffset)
            } completion: { _ in
                self.isExpand.toggle()
                self.delay = 0
                
                if ind == self.buttons.count-1{
                    self.isExpanding = false
                    
                    if !self.isExpand{
                        self.dismiss?()
                    }
                }
                

            }
            
            delay += delayOffset
        }
    }
    
    @objc func buttonClicked(_ sender: UIButton){
        mainClicked()
        let img = buttonImages[sender.tag].image
        mainButton.setImage(img, for: .normal)
        languageDidChoosed?(buttonImages[sender.tag])
        
    }
}
