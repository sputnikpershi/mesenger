//
//  FeedViewController.swift
//  Navigation
//
//  Created by Krime Loma    on 7/25/22.
//

import UIKit

class FeedViewController: UIViewController {
    
    
    private lazy var buttonOne = CustomButton(titleButton: "Posing", cornerRadius: 10, background: .cyan) {}
    
    
    private lazy var buttonTwo = CustomButton(titleButton: "Post 2", cornerRadius: 10, background: .brown) {
        [weak self] in
        let vc = InfoViewController()
        vc.modalPresentationStyle = .fullScreen
        self?.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    private lazy var stackview: UIStackView = {
        let stack = UIStackView(frame: .zero)
        stack.axis = .vertical
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    } ()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonOne.tapButtonOne = { [weak self] in
            let vc = PostViewController()
            vc.postTitle = "My first Post"
            vc.modalPresentationStyle = .fullScreen
            self?.navigationController?.pushViewController(vc, animated: true)
        }
        
        if #available(iOS 13.0, *) { overrideUserInterfaceStyle = .light}
        self.view.backgroundColor = .systemGray3
        self.navigationItem.title = "Feed"
        self.view.addSubview(self.stackview)
        stackview.addArrangedSubview(buttonOne)
        stackview.addArrangedSubview(buttonTwo)
        self.buttonOne.center = self.view.center
        self.tabBarController?.tabBar.backgroundColor = .secondarySystemBackground
        setConstraints()
    }
    
    
    private func setConstraints () {
        let stackviewConstraints = stackviewConstraints ()
        let buttonsConstraints = buttonsConstraints ()
        NSLayoutConstraint.activate(
            stackviewConstraints + buttonsConstraints
        )
    }
    
    
    private func  stackviewConstraints () -> [NSLayoutConstraint] {
        let centerXAnchor = self.stackview.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        let centerYAnchor = self.stackview.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        let leadingAnchor = self.stackview.leadingAnchor.constraint(equalTo: self.view.leadingAnchor)
        let trailingAnchor = self.stackview.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        return [centerXAnchor, centerYAnchor, leadingAnchor, trailingAnchor]
    }
    
    
    private func buttonsConstraints () -> [NSLayoutConstraint] {
        let heightAnchorButtonOne = self.buttonOne.heightAnchor.constraint(equalToConstant: 50)
        let heightAnchorButtonTwo = self.buttonTwo.heightAnchor.constraint(equalToConstant: 50)
        return [heightAnchorButtonOne, heightAnchorButtonTwo]
    }
    
    
    @objc private func didTapButton() {
        let vc = PostViewController()
        vc.postTitle = "My first Post"
        vc.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
