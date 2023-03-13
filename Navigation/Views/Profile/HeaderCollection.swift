//
//  HeaderCollection.swift
//  Navigation
//
//  Created by Kiryl Rakk on 7/3/23.
//

import UIKit

class HeaderCollection: UICollectionReusableView {
    static let identifier =  "HeaderCollection"
    private var initialAvatarFrame = CGRect(x: 16, y: 48, width: 60, height: 60)
    var user : User?
    private var statusText = ""
    weak var profileVC : ProfileViewController?
    weak var viewModel: ProfileViewModel?
    private var widthFrame = (UIScreen.main.bounds.size.width/3)
    
    private lazy var avatarImage : UIImageView = {
        let avatar = UIImageView()
        avatar.image = user?.image
        avatar.clipsToBounds = true
        avatar.contentMode = .scaleAspectFill
        avatar.layer.cornerRadius = self.initialAvatarFrame.height/2
        avatar.translatesAutoresizingMaskIntoConstraints = false
        avatar.isUserInteractionEnabled = true
        return avatar
    }()

    private lazy var nicknameLabel: UILabel = {
        let name = UILabel(frame: CGRect(x: 0, y: 0, width: 0 , height: 0 ))
        name.font = UIFont(name: "Inter-Medium", size: 16)
        name.textColor = UIColor(red: 0.149, green: 0.196, blue: 0.22, alpha: 1)
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()
    
    private lazy var nameLabel: UILabel = {
        let name = UILabel(frame: CGRect(x: 0, y: 0, width: 0 , height: 0 ))
        name.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        name.textColor = UIColor.createColor(lightMode: .black, darkMode: .white)
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()
    
    
    
    private lazy var statusLabel : UILabel = {
        let status = UILabel(frame: .zero)
        status.numberOfLines = 1
        status.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        status.textColor = UIColor.createColor(lightMode: .darkGray, darkMode: .lightGray)
        status.translatesAutoresizingMaskIntoConstraints = false
        return status
    }()
    
    private lazy var infoLabel : UIButton = {
        let button = UIButton(frame: .zero)
        button.setImage(UIImage(systemName: "info.circle.fill"), for: .normal)
        button.imageView?.tintColor = .orange
        button.setTitle(" Больше информации", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.contentHorizontalAlignment = .leading
        button.titleLabel?.font = UIFont(name: "Inter-Medium", size: 14)
        return button
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
        button.backgroundColor = .orange
        let localizationText = NSLocalizedString("profile-status-button", comment: "")
        button.setTitle(localizationText, for: .normal)

        button.layer.cornerRadius = 4
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var logOutButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(UIColor.createColor(lightMode: .black, darkMode: .white), for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 12)
        let localizationText = NSLocalizedString("profile-logout-button", comment: "")
        button.setTitle(localizationText, for: .normal)
        button.addTarget(self, action: #selector(logOutAction), for: .touchUpInside)
        return  button
    }()
    
    private lazy var numbrePost : UILabel = {
        let label = UILabel()
        label.text = "200 \nпубликаций"
        label.textColor = UIColor(red: 1, green: 0.62, blue: 0.271, alpha: 1)
        label.font = UIFont(name: "Inter-Regular", size: 14)
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    } ()
    
    private lazy var numbreFolowed : UILabel = {
        let label = UILabel()
        label.text = "200 \nподписок"
        label.textColor = UIColor(red: 1, green: 0.62, blue: 0.271, alpha: 1)
        label.font = UIFont(name: "Inter-Regular", size: 14)
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    } ()
    
    private lazy var numberFolowers : UILabel = {
        let label = UILabel()
        label.text = "200 \nподписчиков"
        label.textColor = UIColor(red: 1, green: 0.62, blue: 0.271, alpha: 1)
        label.font = UIFont(name: "Inter-Regular", size: 14)
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    } ()
    
    private lazy var separator : UIView = {
        let line = UIView()
        line.backgroundColor = UIColor(red: 0.495, green: 0.507, blue: 0.512, alpha: 1)
        return line
    } ()
    
    private lazy var noteButton : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "edit1"), for: .normal)
        return button
    } ()
    private lazy var noteButtonLabel : UILabel = {
        let label = UILabel()
        label.text = "Запись"
        label.font = UIFont(name: "Inter-Regular", size: 14)
        return label
    } ()
    
    private lazy var historyButton : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "camera1"), for: .normal)
        return button
    } ()
    private lazy var historyButtonLabel : UILabel = {
        let label = UILabel()
        label.text = "История"
        label.font = UIFont(name: "Inter-Regular", size: 14)
        return label
    } ()
    
    private lazy var photoButton : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "photos1"), for: .normal)
        return button
    } ()
    
    private lazy var photoButtonLabel : UILabel = {
        let label = UILabel()
        label.text = "Фото"
        label.font = UIFont(name: "Inter-Regular", size: 14)
        return label
    } ()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setViews()
        setConstraints()
        setGestureRecornizer()
        backgroundColor = .systemBlue
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func setup (user: Account) {
        nameLabel.text = "\(user.name) \(user.surname)"
        avatarImage.image = UIImage(named: user.avatar)
//        nicknameLabel.text = user.nickname
        statusLabel.text = user.status
        widthFrame = self.frame.width
   }
   
   private func setViews () {
       self.addSubview(self.avatarImage)
       self.addSubview(nameLabel)
       self.addSubview(statusLabel)
       self.addSubview(self.viewTF)
       self.addSubview(self.infoLabel)
       self.addSubview(self.profileButton)
//       self.addSubview(nicknameLabel)

//       self.addSubview(self.logOutButton)
       self.addSubview(self.numbrePost)
       self.addSubview(self.numbreFolowed)
       self.addSubview(self.numberFolowers)
       self.addSubview(self.separator)
       self.addSubview(self.noteButton)
       self.addSubview(self.historyButton)
       self.addSubview(self.photoButton)
       self.addSubview(self.noteButtonLabel)
       self.addSubview(self.historyButtonLabel)
       self.addSubview(self.photoButtonLabel)
   }

   
   private func setConstraints () {
   
//       logOutButton.snp.makeConstraints { make in
//           make.top.equalTo(self.snp.top).offset(16)
//           make.trailing.equalToSuperview().offset(-16)
//       }

//       nicknameLabel.snp.makeConstraints { make in
//           make.top.equalTo(self.snp.top).offset(16)
//           make.leading.equalToSuperview().offset(26)
//       }
       
       avatarImage.snp.makeConstraints { make in
           make.top.equalToSuperview().offset(16)
           make.leading.equalToSuperview().offset(16)
           make.width.height.equalTo(60)
       }
       
       nameLabel.snp.makeConstraints { make in
           make.top.equalToSuperview().offset(16)
           make.leading.equalTo(self.avatarImage.snp.trailing).offset(16)
       }
       
       statusLabel.snp.makeConstraints { make in
           make.top.equalTo(self.nameLabel.snp.bottom).offset(4)
           make.leading.equalTo(self.avatarImage.snp.trailing).offset(16)
           make.trailing.equalToSuperview()
       }
       infoLabel.snp.makeConstraints { make in
           make.top.equalTo(self.statusLabel.snp.bottom).offset(8)
           make.leading.equalTo(self.avatarImage.snp.trailing).offset(16)
           make.trailing.equalTo(self.snp.trailing).inset(16)
       }
       profileButton.snp.makeConstraints { make in
           make.top.equalTo(self.infoLabel.snp.bottom).offset(16)
           make.centerX.equalToSuperview()
           make.height.equalTo(47)
           make.width.equalToSuperview().offset(-32)
       }
       
       numbrePost.snp.makeConstraints { make in
           make.top.equalTo(self.profileButton.snp.bottom).offset(20)
           make.leading.equalToSuperview().offset(16)
           make.width.equalTo(widthFrame)
       }
       
       numbreFolowed.snp.makeConstraints { make in
           make.centerY.equalTo(self.numbrePost.snp.centerY)
           make.centerX.equalToSuperview()
           make.width.equalTo(widthFrame)
       }
       
       numberFolowers.snp.makeConstraints { make in
           make.centerY.equalTo(self.numbrePost.snp.centerY)
           make.trailing.equalTo(self.snp.trailing).offset(-16)
           make.width.equalTo(widthFrame)
       }
       
       separator.snp.makeConstraints { make in
           make.top.equalTo(self.numbrePost.snp.bottom).offset(14)
           make.width.equalToSuperview().offset(-32)
           make.centerX.equalToSuperview()
           make.height.equalTo(0.5)
       }
       
       noteButton.snp.makeConstraints { make in
           make.top.equalTo(self.separator.snp.bottom).offset(16)
           make.width.equalTo(24)
           make.height.equalTo(24)
           make.centerX.equalTo(numbrePost.snp.centerX)
       }
       
       noteButtonLabel.snp.makeConstraints { make in
           make.top.equalTo(noteButton.snp.bottom).offset(8)
           make.centerX.equalTo(noteButton.snp.centerX)
           make.bottom.equalToSuperview().offset(-20)
           
       }
       
       historyButton.snp.makeConstraints { make in
           make.centerY.equalTo(noteButton.snp.centerY)
           make.width.equalTo(29)
           make.height.equalTo(29)
           make.centerX.equalToSuperview()
       }
       
       photoButton.snp.makeConstraints { make in
           make.centerY.equalTo(noteButton.snp.centerY)
           make.width.equalTo(24)
           make.height.equalTo(24)
           make.centerX.equalTo(numberFolowers.snp.centerX)
       }
       
      
       
       historyButtonLabel.snp.makeConstraints { make in
           make.top.equalTo(historyButton.snp.bottom).offset(8)
           make.centerX.equalTo(historyButton.snp.centerX)
       }
       
       photoButtonLabel.snp.makeConstraints { make in
           make.top.equalTo(photoButton.snp.bottom).offset(8)
           make.centerX.equalTo(photoButton.snp.centerX)
       }
   }
   
    @objc func buttonPressed () {
        profileVC?.tapEditButton()
        print("pressed")
    }
   
    @objc func statusTextChanged () {
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        infoLabel.resignFirstResponder()
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
