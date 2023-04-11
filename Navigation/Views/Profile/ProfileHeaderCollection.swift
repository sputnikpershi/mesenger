//
//  HeaderCollection.swift
//  Navigation
//
//  Created by Kiryl Rakk on 7/3/23.
//

import UIKit

class ProfileHeaderCollection: UICollectionReusableView {
    static let identifier =  "HeaderCollection"
    private var initialAvatarFrame = CGRect(x: 16, y: 48, width: 60, height: 60)
    var user : Account?
    weak var profileVC : ProfileViewController?
    weak var viewModel: ProfileViewModel?
    private var widthFrame = (UIScreen.main.bounds.size.width/3)

    private lazy var avatarImage : UIImageView = {
        let avatar = UIImageView()
        avatar.image = viewModel?.account.avatar
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
        let name = UILabel()
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
        button.setTitleColor(UIColor.createColor(lightMode: .black, darkMode: .white), for: .normal)
        button.contentHorizontalAlignment = .leading
        button.titleLabel?.font = UIFont(name: "Inter-Medium", size: 14)
        button.addTarget(self, action: #selector(didTapInfoLabel), for: .touchUpInside)
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
    
    private lazy var menuButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.orange, for: .normal)
        button.setImage(UIImage(named: "menu2"), for: .normal)
        button.addTarget(self, action: #selector(didTapMenuAction), for: .touchUpInside)
        return  button
    }()
    
    private lazy var numberPost : UILabel = {
        let label = UILabel()
        label.text = "200 \nпубликаций"
        label.textColor = UIColor(red: 1, green: 0.62, blue: 0.271, alpha: 1)
        label.font = UIFont(name: "Inter-Regular", size: 14)
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    } ()
    
    private lazy var numberFolowed : UILabel = {
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
        button.setImage(UIImage(systemName: "square.and.pencil"), for: .normal)
        button.imageView?.tintColor =  .orange
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
        button.setImage(UIImage(systemName: "camera"), for: .normal)
        button.imageView?.tintColor =  .orange
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
        button.setImage(UIImage(systemName: "photo"), for: .normal)
        button.imageView?.tintColor =  .orange
        return button
    } ()
    
    private lazy var photoButtonLabel : UILabel = {
        let label = UILabel()
        label.text = "Фото"
        label.font = UIFont(name: "Inter-Regular", size: 14)
        return label
    } ()
    
    private lazy var photosView: PhotosView = {
        let view = PhotosView()
        view.buttonTapCallback = { self.profileVC?.searchPost()}
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapPhotoView)))
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setViews()
        setConstraints()
        setGestureRecornizer()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func setup (user: Account) {
        nameLabel.text = "\(user.name) \(user.surname)"
        avatarImage.image = viewModel?.account.avatar
        numberFolowed.text = "\(viewModel?.friends?.count ?? 0) \nподписок"
        numberFolowers.text = "\(viewModel?.friends?.count ?? 0) \nподписчиков"
        numberPost.text = "\(user.posts.count) \nпубликаций"
        statusLabel.text = viewModel?.account.status
   }
   
   private func setViews () {
       self.addSubview(self.avatarImage)
       self.addSubview(nameLabel)
       self.addSubview(statusLabel)
       self.addSubview(self.infoLabel)
       self.addSubview(self.profileButton)
       self.addSubview(self.numberPost)
       self.addSubview(self.numberFolowed)
       self.addSubview(self.numberFolowers)
       self.addSubview(self.separator)
       self.addSubview(self.noteButton)
       self.addSubview(self.historyButton)
       self.addSubview(self.photoButton)
       self.addSubview(self.noteButtonLabel)
       self.addSubview(self.historyButtonLabel)
       self.addSubview(self.photoButtonLabel)
       self.addSubview(self.photosView)
   }

   
   private func setConstraints () {

       avatarImage.snp.makeConstraints { make in
           make.top.equalToSuperview().offset(16)
           make.leading.equalToSuperview().offset(16)
           make.width.height.equalTo(60)
       }
       
       nameLabel.snp.makeConstraints { make in
//           make.top.equalTo(nicknameLabel.snp.bottom).offset(16)
           make.top.equalToSuperview().offset(16)
           make.leading.equalTo(self.avatarImage.snp.trailing).offset(16)
           make.trailing.equalToSuperview().offset(-16)
       }
       
       statusLabel.snp.makeConstraints { make in
           make.top.equalTo(self.nameLabel.snp.bottom).offset(4)
           make.leading.equalTo(self.avatarImage.snp.trailing).offset(16)
           make.trailing.equalToSuperview().offset(-16)
       }
       infoLabel.snp.makeConstraints { make in
           make.top.equalTo(self.statusLabel.snp.bottom).offset(8)
           make.leading.equalTo(self.avatarImage.snp.trailing).offset(16)
           make.trailing.equalToSuperview().offset(-16)
       }
       profileButton.snp.makeConstraints { make in
           make.top.equalTo(self.infoLabel.snp.bottom).offset(16)
           make.centerX.equalToSuperview()
           make.height.equalTo(47)
           make.width.equalToSuperview().offset(-32)
       }
       
       numberPost.snp.makeConstraints { make in
           make.top.equalTo(self.profileButton.snp.bottom).offset(20)
           make.leading.equalToSuperview().offset(16)
           make.width.equalTo(widthFrame)
       }
       
       numberFolowed.snp.makeConstraints { make in
           make.centerY.equalTo(self.numberPost.snp.centerY)
           make.centerX.equalToSuperview()
           make.width.equalTo(widthFrame)
       }
       
       numberFolowers.snp.makeConstraints { make in
           make.centerY.equalTo(self.numberPost.snp.centerY)
           make.trailing.equalTo(self.snp.trailing).offset(-16)
           make.width.equalTo(widthFrame)
       }
       
       
       separator.snp.makeConstraints { make in
           make.top.equalTo(self.numberPost.snp.bottom).offset(14)
           make.width.equalToSuperview().offset(-32)
           make.centerX.equalToSuperview()
           make.height.equalTo(0.5)
       }
       
       noteButton.snp.makeConstraints { make in
           make.top.equalTo(self.separator.snp.bottom).offset(16)
           make.width.height.equalTo(24)
           make.centerX.equalTo(numberPost.snp.centerX)
       }
       
       noteButtonLabel.snp.makeConstraints { make in
           make.top.equalTo(noteButton.snp.bottom).offset(8)
           make.centerX.equalTo(noteButton.snp.centerX)
       }
       
       historyButton.snp.makeConstraints { make in
           make.centerY.equalTo(noteButton.snp.centerY)
           make.width.height.equalTo(29)
           make.centerX.equalToSuperview()
       }
       
       photoButton.snp.makeConstraints { make in
           make.centerY.equalTo(noteButton.snp.centerY)
           make.width.height.equalTo(24)
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
       
       photosView.snp.makeConstraints { make in
           make.top.equalTo(noteButtonLabel.snp.bottom).offset(16)
           make.leading.trailing.equalToSuperview()
           make.height.equalTo(180)
           make.bottom.equalToSuperview().offset(-20)
       }
   }
   
    @objc func buttonPressed () {
        profileVC?.tapEditButton()
    }
   
    @objc func didTapInfoLabel () {
        profileVC?.tapInfo()
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
   
    @objc func didTapPhotoView() {
        self.profileVC?.navigationController?.pushViewController(AlbomsViewController(), animated: true)
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

  @objc func didTapMenuAction () {
      profileVC?.tapMenu()
   }
}
