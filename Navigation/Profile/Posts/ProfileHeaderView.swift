//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Krime Loma    on 7/30/22.
//

import UIKit

class ProfileHeaderView: UIView {
    
    private var statusText = ""
    
    private lazy var avatarImage : UIImageView = {
        let avatar = UIImageView(frame: CGRect(x: 16, y: 16, width: 120, height: 120))
        avatar.backgroundColor = .white
        avatar.layer.borderColor = UIColor.white.cgColor
        avatar.layer.borderWidth = 3
        avatar.image = UIImage(named: "cat")
        avatar.layer.cornerRadius = avatar.bounds.height/2
        avatar.clipsToBounds = true
        avatar.translatesAutoresizingMaskIntoConstraints = false
        return avatar
    }()
    
    private lazy var stackView : UIStackView = {
        let stack = UIStackView(frame: CGRect(x: 152, y: 27, width: 246, height: 95))
        stack.axis = .vertical
//        stack.backgroundColor = .systemGreen
        stack.distribution = .fillEqually
        stack.spacing = 12
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    } ()
    
    private lazy var nameLabel: UILabel = {
        let name = UILabel(frame: CGRect(x: 0, y: 0, width: 0 , height: 0 ))
        name.text = "Товарищ Мау"
        name.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        name.textColor = .black
        return name
    }()
    
    
    private lazy var statusLabel : UILabel = {
        let status = UILabel(frame: .zero)
        status.text = "Дай мне поесть, человечик..."
        status.numberOfLines = 1
        status.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        status.textColor = .darkGray
        return status
    }()
    
    private lazy var profileTextField : UITextField = {
        let textField = UITextField(frame: .zero)
        textField.textColor = .black
        textField.font?.withSize(15)
        textField.addTarget(self, action: #selector(statusTextChanged), for: .editingChanged)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    
    private lazy var viewTF: UIView = {
        let view = UIView (frame: .zero)
        view.backgroundColor = .white
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    private lazy var profileButton : UIButton = {
        let button = UIButton(frame: .zero)
        button.backgroundColor = .systemBlue
        button.setTitle("Show status", for: .normal)
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 4.0, height: 4.0)
        button.layer.masksToBounds = false
        button.layer.shadowRadius = 4
        button.layer.shadowOpacity = 0.7
        button.layer.cornerRadius = 4
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    private func setupView () {
        self.backgroundColor = .lightGray
        self.addSubview(self.avatarImage)
        self.addSubview(self.profileButton)
        self.addSubview(self.stackView)
        self.stackView.addArrangedSubview(nameLabel)
        self.stackView.addArrangedSubview(statusLabel)
        self.addSubview(self.viewTF)
        self.addSubview(self.profileTextField)
    }
    
    private func setConstraints () {
        
        NSLayoutConstraint.activate([
            
            self.avatarImage.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 16),
            self.avatarImage.leadingAnchor.constraint(equalTo:  self.leadingAnchor, constant:  16),
            self.avatarImage.widthAnchor.constraint(equalToConstant: 120 ),
            self.avatarImage.heightAnchor.constraint(equalToConstant: 120),
            
            self.stackView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 27),
            self.stackView.leadingAnchor.constraint(equalTo: self.avatarImage.trailingAnchor, constant: 16),
            self.stackView.trailingAnchor.constraint(lessThanOrEqualTo: self.trailingAnchor, constant: 16),
            
            self.viewTF.topAnchor.constraint(equalTo:  self.stackView.bottomAnchor, constant:  16),
            self.viewTF.leadingAnchor.constraint(equalTo: avatarImage.trailingAnchor, constant: 16),
            self.viewTF.widthAnchor.constraint(equalTo: self.stackView.widthAnchor),
            self.viewTF.heightAnchor.constraint(equalToConstant: 40),
            
            self.profileTextField.topAnchor.constraint(equalTo:  self.viewTF.topAnchor),
            self.profileTextField.leadingAnchor.constraint(equalTo: self.viewTF.leadingAnchor, constant: 10),
            self.profileTextField.trailingAnchor.constraint(equalTo: self.viewTF.trailingAnchor),
            self.profileTextField.heightAnchor.constraint(equalToConstant: 40),
            self.profileTextField.widthAnchor.constraint(equalTo: self.viewTF.widthAnchor, constant: -10),
            
            self.profileButton.topAnchor.constraint(equalTo:  self.profileTextField.bottomAnchor, constant: 16),
            self.profileButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            self.profileButton.trailingAnchor.constraint(equalTo: self.stackView.trailingAnchor),
            self.profileButton.heightAnchor.constraint(equalToConstant: 50),
            self.profileButton.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            self.profileButton.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: -16)
        ] )
    }
   
    @objc func buttonPressed () {
        if statusText != "" && statusText != " " {
            statusLabel.text = statusText
            profileTextField.text = ""
        }
    }
    
    
    @objc func statusTextChanged () {
        statusText = profileTextField.text ?? ""
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        profileTextField.resignFirstResponder()
    }
}


