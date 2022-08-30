////
////  ProfileHeaderView.swift
////  Navigation
////
////  Created by Krime Loma    on 7/30/22.
////
//
//import UIKit
//
//protocol AnimateDelegate: AnyObject {
//    func animateAvatar (avatar:UIImageView)
//    func animateBackground ()
//}
//
//class ProfileHeaderView: UIView {
//   
//    
//    weak var delegate: AnimateDelegate?
//    weak var profileVC : ProfileTableHeaderView?
//    var startFrame = CGRect(x: 0, y: 0, width: 0, height: 0)
//
//    
//    private var statusText = ""
//    
//    private lazy var avatarImage : UIImageView = {
//        let avatar = UIImageView(frame: CGRect(x: 16, y: 16, width: 120, height: 120))
//        avatar.backgroundColor = .white
//        avatar.layer.borderColor = UIColor.white.cgColor
//        avatar.layer.borderWidth = 3
//        avatar.image = UIImage(named: "cat")
//        avatar.layer.cornerRadius = avatar.bounds.height/2
//        avatar.clipsToBounds = true
//        avatar.translatesAutoresizingMaskIntoConstraints = false
//        avatar.isUserInteractionEnabled = true
//        return avatar
//    }()
//    
//    private lazy var stackView : UIStackView = {
//        let stack = UIStackView(frame: .zero)
//        stack.axis = .vertical
////        stack.backgroundColor = .systemGreen
//        stack.distribution = .fillEqually
//        stack.spacing = 12
//        stack.translatesAutoresizingMaskIntoConstraints = false
//        return stack
//    } ()
//    
//    private lazy var nameLabel: UILabel = {
//        let name = UILabel(frame: CGRect(x: 0, y: 0, width: 0 , height: 0 ))
//        name.text = "Товарищ Мау"
//        name.font = UIFont.systemFont(ofSize: 18, weight: .bold)
//        name.textColor = .black
//        return name
//    }()
//    
//    
//    private lazy var statusLabel : UILabel = {
//        let status = UILabel(frame: .zero)
//        status.text = "Дай мне поесть, человечик..."
//        status.numberOfLines = 1
//        status.font = UIFont.systemFont(ofSize: 14, weight: .regular)
//        status.textColor = .darkGray
//        return status
//    }()
//    
//    private lazy var profileTextField : UITextField = {
//        let textField = UITextField(frame: .zero)
//        textField.textColor = .black
//        textField.font?.withSize(15)
//        textField.addTarget(self, action: #selector(statusTextChanged), for: .editingChanged)
//        textField.translatesAutoresizingMaskIntoConstraints = false
//        return textField
//    }()
//    
//    
//    private lazy var viewTF: UIView = {
//        let view = UIView (frame: .zero)
//        view.backgroundColor = .white
//        view.layer.borderWidth = 1
//        view.layer.cornerRadius = 12
//        view.translatesAutoresizingMaskIntoConstraints = false
//        return view
//    }()
//    
//    
//    private lazy var profileButton : UIButton = {
//        let button = UIButton(frame: .zero)
//        button.backgroundColor = .systemBlue
//        button.setTitle("Show status", for: .normal)
//        button.layer.shadowColor = UIColor.black.cgColor
//        button.layer.shadowOffset = CGSize(width: 4.0, height: 4.0)
//        button.layer.masksToBounds = false
//        button.layer.shadowRadius = 4
//        button.layer.shadowOpacity = 0.7
//        button.layer.cornerRadius = 4
//        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
//        button.translatesAutoresizingMaskIntoConstraints = false
//        return button
//    }()
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setupView()
//        setConstraints()
////        setGesture()
//    }
//    
//    required init?(coder: NSCoder) {
//        super.init(coder: coder)
//    }
//    
//    
//    private func setupView () {
//        self.backgroundColor = .lightGray
//        self.addSubview(self.profileButton)
//        self.addSubview(self.stackView)
//        self.stackView.addArrangedSubview(nameLabel)
//        self.stackView.addArrangedSubview(statusLabel)
//        self.addSubview(self.viewTF)
//        self.addSubview(self.profileTextField)
//        self.addSubview(self.avatarImage)
//
//    }
//    private func setConstraints () {
//        
//        NSLayoutConstraint.activate([
//            
//            self.avatarImage.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 16),
//            self.avatarImage.leadingAnchor.constraint(equalTo:  self.leadingAnchor, constant:  16),
//            self.avatarImage.widthAnchor.constraint(equalToConstant: 120 ),
//            self.avatarImage.heightAnchor.constraint(equalToConstant: 120),
//            
//            self.stackView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 27),
//            self.stackView.leadingAnchor.constraint(equalTo: self.avatarImage.trailingAnchor, constant: 16),
//            self.stackView.trailingAnchor.constraint(lessThanOrEqualTo: self.trailingAnchor, constant: 16),
//            
//            self.viewTF.topAnchor.constraint(equalTo:  self.stackView.bottomAnchor, constant:  16),
//            self.viewTF.leadingAnchor.constraint(equalTo: avatarImage.trailingAnchor, constant: 16),
//            self.viewTF.widthAnchor.constraint(equalTo: self.stackView.widthAnchor),
//            self.viewTF.heightAnchor.constraint(equalToConstant: 40),
//            
//            self.profileTextField.topAnchor.constraint(equalTo:  self.viewTF.topAnchor),
//            self.profileTextField.leadingAnchor.constraint(equalTo: self.viewTF.leadingAnchor, constant: 10),
//            self.profileTextField.trailingAnchor.constraint(equalTo: self.viewTF.trailingAnchor),
//            self.profileTextField.heightAnchor.constraint(equalToConstant: 40),
//            self.profileTextField.widthAnchor.constraint(equalTo: self.viewTF.widthAnchor, constant: -10),
//            
//            self.profileButton.topAnchor.constraint(equalTo:  self.profileTextField.bottomAnchor, constant: 16),
//            self.profileButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
//            self.profileButton.trailingAnchor.constraint(equalTo: self.stackView.trailingAnchor),
//            self.profileButton.heightAnchor.constraint(equalToConstant: 50),
//            self.profileButton.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
//            self.profileButton.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: -16)
//        ] )
//    }
//    
//   
//    @objc func buttonPressed () {
//        if statusText != "" && statusText != " " {
//            statusLabel.text = statusText
//            profileTextField.text = ""
//        }
//    }
//    
//    
//    @objc func statusTextChanged () {
//        statusText = profileTextField.text ?? ""
//    }
//    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        super.touchesBegan(touches, with: event)
//        profileTextField.resignFirstResponder()
//    }
//    
////    private  func setGesture () {
////
////        self.avatarImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.setAnimation)))
////    }
//
//
//  
//    
////    @objc func setAnimation () {
////
////
////
////
////        self.animateBackground()
////        self.animateAvatar(ava: avatarImage)
////        }
//        
////    func animateBackground() {
////        profileVC?.animateImageView()
////    }
////
////    func animateAvatar (ava: UIImageView) {
////        profileVC?.animateAvatar(ava: ava)
////    }
//    
////    private func setGestureRecognizer () {
////        let tapGestureRecognizer = UITapGestureRecognizer (target: self, action: #selector(self.handleTapButton))
////        tapGestureRecognizer.numberOfTapsRequired = 1
////        avatarImage.isUserInteractionEnabled = true
////        self.avatarImage.addGestureRecognizer(tapGestureRecognizer)
////    }
////
////
////    @objc func handleTapButton () {
//////
//////        UIView.animate(withDuration: 3, delay: 0, options: .curveEaseIn) {
//////            self.avatarImage.frame = CGRect(x: 150, y: 500, width: 150, height: 150)
//////
//////        } completion: { _ in
//////
//////        }
////
////
////
////
////
////                   //Basic animation
//////
//////        let heightY = ((self.frame.width / self.avatarImage.frame.width) * self.avatarImage.frame.height)
//////
//////                   UIView.animate(withDuration: 0.75, delay: 0, options: .curveEaseIn) {
//////                       self.avatarImage.frame = CGRect (x: 200, y: self.center.y/2, width: self.frame.width, height: heightY)
//////                   } completion: { _ in
//////
//////                   }
//////        self.animateBackground()
////
////
////        // CAAnimation
////        let animation = CABasicAnimation(keyPath: "position")
////        let startCenter = self.avatarImage.center
////        let centerX = self.frame.width/2
////        let centerY = self.frame.height/2
////
////        animation.fromValue = CGRect(x: startCenter.x, y: startCenter.y ,width: 120, height: 120 )
////        animation.toValue = CGRect(x: centerX, y: centerY, width: 500, height: 500)
////        animation.duration = 1
////        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
////        animation.fillMode = .forwards
////        animation.isRemovedOnCompletion = false
////        animation.beginTime = CACurrentMediaTime()
////        avatarImage.layer.add(animation, forKey: nil)
//////        animateBackground()
////
////
////        ///
////        ///
////        ///KEYFRames
////        ///
////
////
////
//////        UIView.animateKeyframes(withDuration: 4, delay: 0, options: .calculationModeCubic) {
//////            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.75) {
//////                let heightY = ((self.frame.width / self.avatarImage.frame.width) * self.avatarImage.frame.height)
//////                self.avatarImage.frame = CGRect (x: 0, y: self.center.y/2, width: self.frame.width, height: heightY )
//////            }
//////        } completion: { _ in
//////
//////        }
////
////
////
////
////    }
////
//////
//////    func animateAvatar () {
//////        profileVC?.animateAvatar(avatar: avatarImage)
//////    }
//////
//////        func animateBackground () {
//////            profileVC?.animateBackground()
//////
//////        }
////
////
////
////
////
////
//
//}
