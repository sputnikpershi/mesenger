//
//  CustomTextField.swift
//  Navigation
//
//  Created by Krime Loma on 7/10/22.
//

import UIKit

class CustomLabel: UILabel {
    
    var textLable : String
    
    init(textLable: String) {
        self.textLable = textLable
        super.init(frame: .zero)
        setup()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setup () {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.text = textLable
    }
    
}
