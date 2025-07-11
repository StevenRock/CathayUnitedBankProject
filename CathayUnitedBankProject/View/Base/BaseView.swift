//
//  BaseView.swift
//  CathayUnitedBankProject
//
//  Created by Steven Lin on 2025/7/11.
//

import UIKit

class BaseView: UIView{
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
        
    func setupUI(){
        self.backgroundColor = .white
    }
}
