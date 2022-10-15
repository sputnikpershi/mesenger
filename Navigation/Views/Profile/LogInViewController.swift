//
//  LogInViewController.swift
//  Navigation
//
//  Created by Krime Loma    on 8/8/22.
//

import UIKit

class LogInViewController: UIViewController, Coordinating {
    
    var coordinator: Coordinator?
    let groupQueue = DispatchGroup()
    let cuncurrentQueue = DispatchQueue(label: "com.app.concurrent", attributes: [.concurrent])
    var loginDelegate : LoginViewControllerDelegate?
    let setColor: UIColor = UIColor(red: 0.28, green: 0.52, blue: 0.80, alpha: 1.00)
   
    
 
    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView ()
        scroll.backgroundColor = .white
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
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
        login.placeholder = "Email or phone (test)"
        login.text = "test"
        login.textColor = .black
        login.autocapitalizationType = .none
        return login
    } ()
    
    private lazy var pswdTF: UITextField = {
        let pswd = UITextField ()
        pswd.translatesAutoresizingMaskIntoConstraints = false
        pswd.placeholder = "Password (test)"
        pswd.textColor = .black
        pswd.autocapitalizationType = .none
        pswd.isSecureTextEntry = true
        return pswd
    } ()
    
    private lazy var loginButton : UIButton  = {
        let button = UIButton ()
        button.setBackgroundImage(UIImage(named: "blue_pixel"), for: .normal)
        button.setTitle("Log In", for: .normal)
        button.clipsToBounds = true
        button.layer.cornerRadius = 10
        button.isEnabled = true
        button.setBackgroundImage(UIImage(named: "blue_pixel"), for: .normal )
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(self.tapButton), for: .touchUpInside)
        return button
    } ()
//
//
//    private lazy var bruteButton = BruteButton(title: "Подобрать пароль", color: .black) {    [weak self] in
//
//        self?.activityIndicator.startAnimating()
//
//        self?.groupQueue.enter()
//        self?.cuncurrentQueue.sync {
//            let generatedPassword = BruteForce().generatePassword(length: 3)
//            self?.globalPswd = generatedPassword
//            self?.groupQueue.leave()
//        }
//
//        self?.groupQueue.enter()
//        self?.cuncurrentQueue.async {
//            self?.brutePswd =  BruteForce().bruteForce(passwordToUnlock: self?.globalPswd ?? "")
//            self?.groupQueue.leave()
//        }
//
//        self?.groupQueue.notify(queue: .main) {
//            self?.pswdTF.text = self?.brutePswd
//            self?.activityIndicator.stopAnimating()
//            print("finished")
//        }
//
//
//    }
    
    // MARK: VIEWDIDLOAD

    override func viewDidLoad() {
        super.viewDidLoad()
        loginButton.alpha = 0.8
        if #available(iOS 13.0, *) { overrideUserInterfaceStyle = .light}
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
        self.scrollView.addSubview(loginButton)

        self.stackView.addArrangedSubview(lineStackView)
        self.stackView.addArrangedSubview(loginTF)
        self.stackView.addArrangedSubview(pswdTF)

        self.view.addSubview(self.lineStackView)
        self.view.addSubview(self.loginTF)
        self.view.addSubview(self.pswdTF)
    }
    
    
    private func setConstraints() {
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
        
            self.scrollView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            
        


            
        ])
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
        print("login \(login) - pswd \(passwd)")
        let checkLogin = MyLoginFactory().makeLoginInspector().check(login: login, password: passwd)
        
        
        
        if  checkLogin {
            print(true)
            let user = User(login: "test", fullName: "Тестанутый Тестамес", image: UIImage(named: "cat")!, status: "Я тебя тестирую на наличие багов")
            let profileVM = ProfileViewModel(user: user)
            let profileVC = ProfileViewController(viewModel: profileVM)
            navigationController?.setViewControllers([profileVC], animated: true)
        } else {
            let alert = UIAlertController(title: "Unknown login", message: "Please, enter correct user login", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            self.present(alert, animated: true)
        }
    }
}

