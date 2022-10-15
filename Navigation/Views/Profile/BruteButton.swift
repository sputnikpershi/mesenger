////
////  BruteButton.swift
////  Navigation
////
////  Created by Kiryl Rakk on 14/10/22.
////
//
//import Foundation
//import UIKit
//
//class BruteButton: UIButton {
//    
//    let buttonTitle: String
//    let buttonColor: UIColor
//    var buttonAction: () -> ()
//    
//    init(title: String, color: UIColor, action: @escaping () -> ()) {
//        self.buttonColor = color
//        self.buttonTitle = title
//        self.buttonAction = action
//        super.init(frame: .zero)
//        self.setup()
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    private func setup() {
//        self.setTitle(buttonTitle, for: .normal)
//        self.backgroundColor = buttonColor
//        self.titleLabel?.font = self.titleLabel?.font.withSize(12)
//        self.configuration?.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
//        self.layer.cornerRadius = 5
//        self.translatesAutoresizingMaskIntoConstraints = false
//        self.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
//       
//
//    }
//    
//    @objc private func didTapButton() {
//        print("tapped")
//        buttonAction()
//    }
//}
