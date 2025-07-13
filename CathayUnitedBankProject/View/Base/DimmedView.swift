//
//  DimmedView.swift
//  CathayUnitedBankProject
//
//  Created by Steven Lin Macmini on 2025/7/13.
//

import UIKit

class DimmedView: BaseView {
    public override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black.withAlphaComponent(0.5)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismiss))
        self.addGestureRecognizer(tap)
        
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func dismiss() {
        self.removeFromSuperview()
    }
}
