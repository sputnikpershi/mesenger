//
//  CustomTextField.swift
//  Navigation
//
//  Created by Kiryl Rakk on 11/10/22.
//

import UIKit

class CustomTextField: UITextField {
    
    var cornerRadius: CGFloat
    var placeholderText : String
    var color: UIColor
    
    init(cornerRadius: CGFloat, placeholder: String, backgroundColor: UIColor) {
        self.cornerRadius = cornerRadius
        self.placeholderText  = placeholder
        self.color = backgroundColor
        super.init(frame: .zero)
        setup()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setup () {
        self.placeholder = "Text"
        self.autocapitalizationType = .none
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = color
    }
}
