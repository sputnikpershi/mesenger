//
//  LogInViewController.swift
//  Navigation
//
//  Created by Krime Loma    on 8/8/22.
//

import UIKit
import SnapKit
import RealmSwift
import KeychainAccess

protocol CheckerServiceProtocol {
    func signIn(_ email: String, password: String) -> String
    func signUp(_ email: String, password: String) -> String
    func showAccount()
    func showCreateAcccount(_ email: String, password: String)
    func showAllertAutherization(text: String)
}

class LogInViewController: UIViewController {
    
    let userDefault = UserDefaults.standard
    let user = ServiceLogIn()
    let keyChain = Keychain()
    var coordinator : ProfileTabCoordinator?
    let groupQueue = DispatchGroup()
    let cuncurrentQueue = DispatchQueue(label: "com.app.concurrent", attributes: [.concurrent])
    let setColor: UIColor = UIColor(red: 0.28, green: 0.52, blue: 0.80, alpha: 1.00)
    private lazy var localAuthorizationService = LocalAuthorizationService()
    
    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView ()
        scroll.backgroundColor = UIColor.createColor(lightMode: .white, darkMode: .black)
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    private lazy var loadIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        return indicator
    }()
    
    private lazy var  iconImage : UIImageView = {
        let image = UIImageView ()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "logo")
        return image
    } ()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.backgroundColor = .systemGray6
        stack.layer.borderColor = UIColor.lightGray.cgColor
        stack.layer.borderWidth = 0.5
        stack.layer.cornerRadius = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    } ()
    
    
    private lazy var lineStackView : UIView = {
        let line = UIView()
        line.backgroundColor = .lightGray
        line.translatesAutoresizingMaskIntoConstraints = false
        return line
    }()
    
    
    private lazy var loginTF: UITextField = {
        let login = UITextField ()
        login.translatesAutoresizingMaskIntoConstraints = false
        let localizationText = NSLocalizedString("login-email", comment: "")
        login.placeholder = localizationText
        login.textColor = UIColor.createColor(lightMode: .black, darkMode: .white)
        login.autocapitalizationType = .none
        return login
    } ()
    
    private lazy var pswdTF: UITextField = {
        let pswd = UITextField ()
        pswd.translatesAutoresizingMaskIntoConstraints = false
        let localizationText = NSLocalizedString("login-pswd", comment: "")
        pswd.placeholder = localizationText
        pswd.textColor = UIColor.createColor(lightMode: .black, darkMode: .white)
        pswd.autocapitalizationType = .none
        pswd.isSecureTextEntry = true
        return pswd
    } ()
    
    private lazy var registrationLabel: UILabel = {
        let label = UILabel()
        let underlineText = NSAttributedString(string: "Хотите зарегистрироваться?",
                                               attributes: [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue])
        label.attributedText = underlineText
        label.alpha = 0
        label.textColor = .black
        label.isUserInteractionEnabled = true
        return label
    }()
    
    
    private lazy var loginButton : UIButton  = {
        let button = UIButton ()
        button.setBackgroundImage(UIImage(named: "blue_pixel"), for: .normal)
        let localizationText = NSLocalizedString("login-button",  comment: "")
        
        button.setTitle(localizationText, for: .normal)
        button.clipsToBounds = true
        button.layer.cornerRadius = 10
        button.isEnabled = true
        button.setBackgroundImage(UIImage(named: "blue_pixel"), for: .normal )
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(self.tapButton), for: .touchUpInside)
        return button
    } ()
    
    
    private lazy var faceIDBUtton: UIButton = {
        let button = UIButton ()
        button.setTitleColor(.systemBlue, for: .normal)
        let text = localAuthorizationService.context.biometricType == .faceID ? "Face ID" : "Touch ID"
        button.setTitle(text, for: .normal)
        button.addTarget(self, action: #selector(tapFaceIDButton), for: .touchUpInside)
        return button

    }()
    
    // MARK: VIEWDIDLOAD
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.view.backgroundColor = UIColor.createColor(lightMode: .white, darkMode: .black)
        loginButton.alpha = 0.8
        loginButton.isEnabled = false
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.isHidden = true
        setViews()
        setConstraints()
        self.setGesture()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.pswdTF.becomeFirstResponder()
        self.pswdTF.isSecureTextEntry = false
    }
    
    private func setViews () {
        self.view.addSubview(self.scrollView)
        self.view.addSubview(self.iconImage)
        self.scrollView.addSubview(stackView)
        self.scrollView.addSubview(iconImage)
        self.scrollView.addSubview(registrationLabel)
        self.scrollView.addSubview(loginButton)
        
        self.stackView.addArrangedSubview(lineStackView)
        self.stackView.addArrangedSubview(loginTF)
        self.stackView.addArrangedSubview(pswdTF)
        
        self.view.addSubview(self.lineStackView)
        self.view.addSubview(self.loginTF)
        self.view.addSubview(self.pswdTF)
        self.view.addSubview(self.loadIndicator)
        self.view.addSubview(faceIDBUtton)
    }
    
    private func setConstraints() {
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        loadIndicator.snp.makeConstraints { make in
            make.trailing.equalTo(self.loginButton.snp.trailing).offset(-16)
            make.centerY.equalTo(self.loginButton.snp.centerY)
        }
        
        registrationLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(self.stackView.snp.top).offset(-30)
        }
        
        NSLayoutConstraint.activate([
            self.iconImage.topAnchor.constraint(equalTo: self.scrollView.topAnchor, constant: 120),
            self.iconImage.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor),
            self.iconImage.widthAnchor.constraint(equalToConstant: 100),
            self.iconImage.heightAnchor.constraint(equalTo: self.iconImage.widthAnchor),
            
            self.stackView.topAnchor.constraint(equalTo: iconImage.bottomAnchor, constant: 120),
            self.stackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.stackView.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant:  -32),
            self.stackView.heightAnchor.constraint(equalToConstant: 100),
            
            self.lineStackView.heightAnchor.constraint(equalToConstant: 0.5),
            self.lineStackView.widthAnchor.constraint(equalTo: self.stackView.widthAnchor),
            self.lineStackView.centerYAnchor.constraint(equalTo: self.stackView.centerYAnchor),
            self.lineStackView.centerXAnchor.constraint(equalTo: self.stackView.centerXAnchor),
            
            self.loginTF.centerXAnchor.constraint(equalTo: self.stackView.centerXAnchor),
            self.loginTF.topAnchor.constraint(equalTo: self.stackView.topAnchor, constant:  6),
            self.loginTF.widthAnchor.constraint(equalTo: self.stackView.widthAnchor, constant: -24),
            self.loginTF.bottomAnchor.constraint(equalTo: self.lineStackView.topAnchor, constant: -6),
            
            self.pswdTF.centerXAnchor.constraint(equalTo: self.stackView.centerXAnchor),
            self.pswdTF.topAnchor.constraint(equalTo: self.lineStackView.bottomAnchor, constant:  6),
            self.pswdTF.widthAnchor.constraint(equalTo: self.stackView.widthAnchor, constant: -24),
            self.pswdTF.bottomAnchor.constraint(equalTo: self.stackView.bottomAnchor, constant: -6),
            
            self.loginButton.topAnchor.constraint(equalTo: self.stackView.bottomAnchor, constant: 16),
            self.loginButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.loginButton.widthAnchor.constraint(equalTo: self.stackView.widthAnchor),
            self.loginButton.heightAnchor.constraint(equalToConstant: 50),
            
        ])
        
        faceIDBUtton.snp.makeConstraints { make in
            make.top.equalTo(self.loginButton.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
    }
    
    private  func setGesture () {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    
    @objc private func hideKeyboard () {
        self.view.endEditing(true )
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(self.didShowKeyboard(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.didHideKeyboard(_:)), name: UIResponder.keyboardDidHideNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.didWroteLoginAndPswd), name: UITextField.textDidChangeNotification, object: nil)
    }
    
    
    @objc private func didWroteLoginAndPswd () {
        if loginTF.hasText && pswdTF.hasText {
            loginButton.alpha = 1
            loginButton.isEnabled = true
        } else {
            loginButton.alpha = 0.8
            loginButton.isEnabled = false
        }
    }
    
    @objc func tapFaceIDButton () {
        let localAuthorizationService = LocalAuthorizationService()
        localAuthorizationService.vc = self
        localAuthorizationService.authorizeIfPossible(viewVontroller: self) { result in
            switch result {
            case .success(let success):
                print(success)
            case .failure(let error):
                print( "----- \(error)")
            }
    
        }
    }
    
    @objc private func didShowKeyboard (_ notification: Notification) {
        if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey]  as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            let loginButtonPointBottomY = self.loginButton.frame.origin.y + 50
            let keyboardOriginY =  self.view.frame.height - keyboardHeight
            let offset = keyboardOriginY < loginButtonPointBottomY ? loginButtonPointBottomY -  keyboardOriginY + 16 : 0
            self.scrollView.contentOffset = CGPoint(x: 0, y: offset)
        }
    }
    
    
    @objc private func didHideKeyboard (_ notification: Notification) {
        self.hideKeyboard()
        self.scrollView.setContentOffset(.zero, animated: true )
    }
    
    
    @objc private func  tapButton() {
        let login =  self.loginTF.text ?? ""
        let passwd =  self.pswdTF.text ?? ""
        let accountHelper = LoginHelper()
        accountHelper.delegate = self
        if self.loginTF.text != "" && self.loginTF.text != " " {
            accountHelper.signIn(login, password: passwd)
        } else  {
            showAllertAutherization(text: "plese enter your login")
        }
        
    }
    
    
    func showCreateAcccount(_ email: String, password: String) {
        
        print("Create account")
        let localizationAlertTitle = NSLocalizedString("alert-title" , comment: "")
        let localizationAlertMessage = NSLocalizedString("alert-message" , comment: "")
        let localizationAlertCancelButton = NSLocalizedString("alert-cancel" , comment: "")
        let localizationAlertOkButton = NSLocalizedString("alert-ok" , comment: "")
        let alert = UIAlertController(title: localizationAlertTitle, message: localizationAlertMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: localizationAlertCancelButton, style: .destructive))
        alert.addAction(UIAlertAction(title: localizationAlertOkButton, style: .default, handler: { _ in
            let accountHelper = LoginHelper()
            accountHelper.delegate = self
            accountHelper.signUp(email, password: password)
        }))
        self.loadIndicator.stopAnimating()
        self.present(alert, animated: true)
    }
    
    
    func showAccount() {
        print("Show account")
        loginTF.text = ""
        pswdTF.text = ""
        let user = User(login: "test", fullName: "Кот Тестировщик", image: UIImage(named: "cat")!, status: "Я тебя тестирую на наличие багов")
        let profileVM = ProfileViewModel(user: user)
        navigationController?.pushViewController(ProfileViewController(viewModel: profileVM), animated: true)
    }
    
    
    func showAllertAutherization(text: String) {
        let alert = UIAlertController(title: "Autherization error", message: text , preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel))
        self.present(alert, animated: true)
    }
}


extension LogInViewController: CheckerServiceProtocol {
    
    func signIn(_ email: String, password: String) -> String{
        print(user.getKey().hexEncodedString())
        let config = Realm.Configuration(encryptionKey: user.getKey())
        do {
            // Open the encrypted realm
            let realm = try Realm(configuration: config) // set Config with encrypted key
            let users = realm.objects(UserLogin.self)
            
            print(users)
            if users.contains(where: { user in
                user.login == email && user.password == password
            }) {
                userDefault.set(true, forKey: "hasLogedIn")
                self.showAccount()
            } else {
                showCreateAcccount(email, password: password) //show alert to create account
            }
        } catch let error as NSError {
            fatalError("Error opening realm: \(error.localizedDescription)")
        }
        return email
    }
    
    func signUp(_ email: String, password: String) -> String {
        user.saveLogIngData(login: email, password: password)
        self.showAccount() //show next ViewController
        userDefault.set(true, forKey: "hasLogedIn") // save info about first login
        return email
    }
    
}


extension Data {
    struct HexEncodingOptions: OptionSet {
        let rawValue: Int
        static let upperCase = HexEncodingOptions(rawValue: 1 << 0)
    }

    func hexEncodedString(options: HexEncodingOptions = []) -> String {
        let format = options.contains(.upperCase) ? "%02hhX" : "%02hhx"
        return self.map { String(format: format, $0) }.joined()
    }
}
