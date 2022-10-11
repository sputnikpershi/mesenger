//
//  FeedViewController.swift
//  Navigation
//
//  Created by Krime Loma    on 7/25/22.
//

import UIKit

class FeedViewController: UIViewController {
    
    private lazy var buttonOne =  CustomButton(title: "Button One", color: .systemBlue) {
        [weak self] in self?.viewModel?.buttonAction(event: .tapLoginButton1)}
    
    private lazy var buttonTwo =  CustomButton(title: "Button Two", color: .systemGray) {
        [weak self] in self?.viewModel?.buttonAction(event: .tapLoginButton2) }
    
    private lazy var textField  = CustomTextField(cornerRadius: 10, placeholder: "text", backgroundColor: .white)
    
    private lazy var checkGuessButton = CustomButton(title: "Check", color: .systemOrange){}
    
    private lazy var indicatorLabel = CustomLabel(textLable: "Result")
    
    private lazy var stackview: UIStackView = {
        let stack = UIStackView(frame: .zero)
        stack.axis = .vertical
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    } ()
    
    private var viewModel: FeedViewModel?
    
    init(viewModel: FeedViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setSubViews()
        setConstraints()
        setCheckButtonAction ()
        customizingVC()
    }
    
    
    private func customizingVC() {
        if #available(iOS 13.0, *) { overrideUserInterfaceStyle = .light}
        self.view.backgroundColor = .systemGray3
        self.navigationItem.title = "Feed"
        self.tabBarController?.tabBar.backgroundColor = .secondarySystemBackground
    }
    
    private func setSubViews() {
        self.view.addSubview(self.stackview)
        stackview.addArrangedSubview(indicatorLabel)
        stackview.addArrangedSubview(textField)
        stackview.addArrangedSubview(checkGuessButton)
        stackview.addArrangedSubview(buttonOne)
        stackview.addArrangedSubview(buttonTwo)
        self.view.addSubview(self.indicatorLabel)
    }
    
    func setCheckButtonAction () {
        checkGuessButton.action = { [weak self] in
            let word = self?.textField.text ?? ""
            let check = self?.viewModel?.check(word: word) ?? false
            if check {
                self?.indicatorLabel.textColor = .green
                self?.textField.text = ""
            } else {
                self?.indicatorLabel.textColor = .red
                self?.textField.text = ""
            }
        }
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
            self.indicatorLabel.bottomAnchor.constraint(equalTo: self.stackview.topAnchor, constant: -50),
        ])
    }
}
