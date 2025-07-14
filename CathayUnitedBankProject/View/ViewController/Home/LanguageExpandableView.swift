//
//  LanguageExpandableView.swift
//  CathayUnitedBankProject
//
//  Created by Steven Lin Macmini on 2025/7/13.
//

import UIKit

class LanguageExpandableView: DimmedView {
    
    private lazy var expandableView: ExpandableButtonGroupView = {
        let v = ExpandableButtonGroupView(frame: CGRect(x: 10, y: 55, width: 40, height: 40))
        v.buttonImages = Language.allCases
        v.dismiss = {
            self.dismiss()
        }
        
        return v
    }()
    
    var revealButton: (()->Void)?
    
    var languageDidChoosed:((Language)->Void)?{
        didSet{
            expandableView.languageDidChoosed = languageDidChoosed
        }
    }
    
    override func removeFromSuperview() {
        super.removeFromSuperview()
        revealButton?()
    }
    
    override func setupUI() {
        self.addSubview(expandableView)
        expandableView.mainClicked()
    }
}
