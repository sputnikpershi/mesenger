//
//  CustomButton.swift
//  Navigation
//
//  Created by Krime Loma on 6/10/22.
//

import UIKit

class CustomButton: UIButton {
    var titleButton : String
    var cornerRadius: CGFloat
    var background: UIColor
    var tapAction : () -> Void
    
    init(titleButton: String,cornerRadius: CGFloat, background: UIColor, taping: @escaping () -> Void ) {
        self.titleButton = titleButton
        self.cornerRadius = cornerRadius
        self.background = background
        self.tapAction = taping
        super.init(frame: .zero)
        setup()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setup () {
        self.setTitle(titleButton, for: .normal)
        self.layer.cornerRadius = cornerRadius
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = background
        self.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }
    
    
    @objc private func didTapButton() {
        tapAction()
    }
}


