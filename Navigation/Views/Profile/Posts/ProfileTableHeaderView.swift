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

   
    
    private lazy var nameLabel: UILabel = {
        let name = UILabel(frame: CGRect(x: 0, y: 0, width: 0 , height: 0 ))
        name.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        name.textColor = .black
        name.translatesAutoresizingMaskIntoConstraints = false

        return name
    }()
    
    private lazy var statusLabel : UILabel = {
        let status = UILabel(frame: .zero)
        status.numberOfLines = 1
        status.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        status.textColor = .darkGray
        status.translatesAutoresizingMaskIntoConstraints = false

        return status
    }()
    
    private lazy var profileTextField : UITextField = {
        let textField = UITextField(frame: .zero)
        textField.textColor = .black
        textField.font?.withSize(15)
        textField.layer.cornerRadius = 5
        textField.backgroundColor = .white
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
        let localizationText = NSLocalizedString("profile-status-button", comment: "")
        button.setTitle(localizationText, for: .normal)
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
        let localizationText = NSLocalizedString("profile-logout-button", comment: "")
        button.setTitle(localizationText, for: .normal)
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
        self.addSubview(nameLabel)
        self.addSubview(statusLabel)
        self.addSubview(self.viewTF)
        self.addSubview(self.profileTextField)
        self.addSubview(self.avatarImage)
        self.addSubview(self.logOutButton)
    }
    
    
    private func setConstraints () {
        background.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        logOutButton.snp.makeConstraints { make in
            make.top.equalTo(self.background.snp.top).offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }

        profileTextField.snp.makeConstraints { make in
            make.top.equalTo(self.statusLabel.snp.bottom).offset(16)
            make.leading.equalTo(self.avatarImage.snp.trailing).offset(16)
            make.height.equalTo(40)
            make.trailing.equalTo(self.snp.trailing).inset(16)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(self.background.snp.top).offset(16)
            make.leading.equalTo(self.avatarImage.snp.trailing).offset(16)
            make.trailing.equalToSuperview()
        }
        
        statusLabel.snp.makeConstraints { make in
            make.top.equalTo(self.nameLabel.snp.bottom).offset(16)
            make.leading.equalTo(self.avatarImage.snp.trailing).offset(16)
            make.trailing.equalToSuperview()
        }
        
        profileButton.snp.makeConstraints { make in
            make.top.equalTo(self.profileTextField.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
            make.bottom.equalTo(self.background.snp.bottom)
        }
        
        
        NSLayoutConstraint.activate([
            avatarImageWidthConstraint, avatarImageHeightConstraint, avatarImageLeadingConstraint, avatarImageTopConstraint,
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
    }
}
