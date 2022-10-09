//
//  FeedViewController.swift
//  Navigation
//
//  Created by Krime Loma    on 7/25/22.
//

import UIKit

class FeedViewController: UIViewController {
    
    private lazy var buttonOne = CustomButton(titleButton: "BUTTON !", cornerRadius: 10, background: .cyan) {}
    
    private lazy var buttonTwo = CustomButton(titleButton: "BUTTON 2", cornerRadius: 10, background: .brown) {}
    
    private lazy var  checkGuessButton = CustomButton(titleButton: "CHECK", cornerRadius: 10, background: .systemPurple) {}
    
    private lazy var textField  = CustomTextField(cornerRadius: 10, placeholder: "text", backgroundColor: .white)
    
    private lazy var indicatorLabel = CustomLabel(textLable: "Result")
    
    private lazy var stackview: UIStackView = {
        let stack = UIStackView(frame: .zero)
        stack.axis = .vertical
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    } ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setActions()
        setView()
        setConstraints()
    }
    
    private func setActions () {
        
        buttonOne.tapAction = { [weak self] in
            let vc = PostViewController()
            vc.postTitle = "My first Post"
            vc.modalPresentationStyle = .fullScreen
            self?.navigationController?.pushViewController(vc, animated: true)
        }
        
        buttonTwo.tapAction = {
            [weak self] in
            let vc = InfoViewController()
            vc.modalPresentationStyle = .fullScreen
            self?.navigationController?.pushViewController(vc, animated: true)
        }
        
        checkGuessButton.tapAction = {
            [weak self] in
            let word = self?.textField.text ?? ""
            let checkModel = FeedModel()
            if checkModel.check(word: word) {
                self?.indicatorLabel.textColor = .green
                self?.textField.text = ""
                
                self?.indicatorLabel.textColor = .black
                
            } else {
                self?.indicatorLabel.textColor = .red
                self?.textField.text = ""
            }
        }
    }
    
    private func setView () {
        if #available(iOS 13.0, *) { overrideUserInterfaceStyle = .light}
        self.view.backgroundColor = .systemGray3
        self.navigationItem.title = "Feed"
        self.tabBarController?.tabBar.backgroundColor = .secondarySystemBackground
        self.view.addSubview(self.stackview)
        stackview.addArrangedSubview(indicatorLabel)
        stackview.addArrangedSubview(textField)
        stackview.addArrangedSubview(checkGuessButton)
        stackview.addArrangedSubview(buttonOne)
        stackview.addArrangedSubview(buttonTwo)
        self.view.addSubview(self.indicatorLabel)
    }
    
    
    private func setConstraints () {
        
        NSLayoutConstraint.activate([
            self.stackview.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.stackview.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            self.stackview.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.stackview.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            
            self.buttonOne.heightAnchor.constraint(equalToConstant: 50),
            self.buttonTwo.heightAnchor.constraint(equalToConstant: 50),
            self.checkGuessButton.heightAnchor.constraint(equalToConstant: 50),
            self.textField.heightAnchor.constraint(equalToConstant: 50),
            
            self.indicatorLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.indicatorLabel.bottomAnchor.constraint(equalTo: self.stackview.topAnchor)
        ])
    }
}
