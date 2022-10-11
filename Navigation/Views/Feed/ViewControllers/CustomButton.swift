//
//  CustomButton.swift
//  Navigation
//
//  Created by Kiryl Rakk on 11/10/22.
//

import UIKit

class CustomButton: UIButton {
    var title: String
    var color: UIColor
    var action: () -> ()
    
    init(title: String, color: UIColor, action: @escaping () -> () ) {
        self.title = title
        self.color = color
        self.action = action
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setup(){
        self.setTitle(title, for: .normal)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = color
        self.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }
    
    @objc private func didTapButton() {
             action()
         }
}
