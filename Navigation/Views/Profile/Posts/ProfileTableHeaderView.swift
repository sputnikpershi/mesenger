//
//  ProfileTableHeaderView.swift
//  Navigation
//
//  Created by Krime Loma    on 8/14/22.
//

import Foundation
import UIKit
import SnapKit
import Firebase

class ProfileTableHeaderView: UITableViewHeaderFooterView {
    
    
    private var initialAvatarFrame = CGRect(x: 16, y: 16, width: 120, height: 120)
    var user : User?
    private var statusText = ""
    weak var profileVC : ProfileViewController?
    weak var viewModel: ProfileViewModel?

    
    private lazy var background : UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var avatarImage : UIImageView = {
        let avatar = UIImageView()
        avatar.image = user?.image
        avatar.clipsToBounds = true
        avatar.contentMode = .scaleAspectFill
        avatar.layer.borderColor = UIColor.white.cgColor
        avatar.layer.borderWidth = 3
        print (avatar.frame.size.height/2)
        avatar.layer.cornerRadius = self.initialAvatarFrame.height/2
        avatar.translatesAutoresizingMaskIntoConstraints = false
        avatar.isUserInteractionEnabled = true
        return avatar
    }()

    private lazy var stackView : UIStackView = {
        let stack = UIStackView(frame: .zero)
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 12
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    } ()
    
    private lazy var nameLabel: UILabel = {
        let name = UILabel(frame: CGRect(x: 0, y: 0, width: 0 , height: 0 ))
        name.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        name.textColor = .black
        return name
    }()
    
    private lazy var statusLabel : UILabel = {
        let status = UILabel(frame: .zero)
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
    
    private lazy var logOutButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 12)
        button.setTitle("Log out", for: .normal)
        button.addTarget(self, action: #selector(logOutAction), for: .touchUpInside)
        return  button
    }()
    
    private var avatarImageWidthConstraint: NSLayoutConstraint?
    private var avatarImageHeightConstraint: NSLayoutConstraint?
    private var avatarImageLeadingConstraint: NSLayoutConstraint?
    private var avatarImageTopConstraint: NSLayoutConstraint?

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setViews()
        
        self.avatarImageWidthConstraint =
        self.avatarImage.widthAnchor.constraint(equalToConstant: 120 )
        self.avatarImageHeightConstraint =
        self.avatarImage.heightAnchor.constraint(equalToConstant: 120)
        self.avatarImageLeadingConstraint =
        self.avatarImage.leadingAnchor.constraint(equalTo:  self.leadingAnchor, constant:  16)
        self.avatarImageTopConstraint =
        self.avatarImage.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 16)
        if #available(iOS 13.0, *) { overrideUserInterfaceStyle = .light}
        setConstraints()
        setGestureRecornizer()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
     func setup (user: User) {
        avatarImage.image = user.image
        nameLabel.text = user.fullName
        statusLabel.text = user.status
    }
    
    
    private func setViews () {
        self.addSubview(self.background)
        self.addSubview(self.profileButton)
        self.addSubview(self.stackView)
        self.stackView.addArrangedSubview(nameLabel)
        self.stackView.addArrangedSubview(statusLabel)
        self.addSubview(self.viewTF)
        self.addSubview(self.profileTextField)
        self.addSubview(self.avatarImage)
        self.addSubview(self.logOutButton)
    }
    
    
    private func setConstraints () {
        logOutButton.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        NSLayoutConstraint.activate([
            avatarImageWidthConstraint, avatarImageHeightConstraint, avatarImageLeadingConstraint, avatarImageTopConstraint,
            
            self.stackView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 27),
            self.stackView.leadingAnchor.constraint(equalTo: self.avatarImage.trailingAnchor, constant: 16),
            self.stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            
            self.viewTF.topAnchor.constraint(equalTo:  self.stackView.bottomAnchor, constant:  16),
            self.viewTF.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -16),
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
            self.profileButton.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: -16),
//
            self.background.topAnchor.constraint(equalTo: self.topAnchor),
            self.background.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.background.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.background.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ].compactMap({$0}))
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
    
    
    
    private func setGestureRecornizer() {
        avatarImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.handleTapAction)))
    }
    
    
    @objc func handleTapAction () {
         self.profileVC?.animateAvatar(ava: self.avatarImage)
    }
    
    
    func animateImageView () {
        let backView = UIView()
        backView.translatesAutoresizingMaskIntoConstraints = false
        backView.isUserInteractionEnabled = true
        backView.frame = self.frame
        backView.backgroundColor = .red
        backView.alpha = 0.5
        self.addSubview(backView)
    }
    
   @objc func logOutAction () {
       self.profileVC?.logOutAction()
       print("header log out")
    }
}
