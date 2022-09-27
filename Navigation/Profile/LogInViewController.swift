//
//  LogInViewController.swift
//  Navigation
//
//  Created by Krime Loma    on 8/8/22.
//

import UIKit

class LogInViewController: UIViewController {
    
    
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
        login.placeholder = "Email or phone"
        login.textColor = .black
        login.autocapitalizationType = .none
        return login
    } ()
    
    
    private lazy var pswdTF: UITextField = {
        let pswd = UITextField ()
        pswd.translatesAutoresizingMaskIntoConstraints = false
        pswd.placeholder = "Password"
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
        button.isEnabled = false
        button.setBackgroundImage(UIImage(named: "blue_pixel"), for: .normal )
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(self.tapButton), for: .touchUpInside)
        return button
    } ()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginButton.alpha = 0.8
        
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        }
        
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.isHidden = true
        
        setViews()
        setConstraints()
        self.setGesture()
        
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
            self.scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.loginTF.becomeFirstResponder()
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
        let vc = ProfileViewController()
        let login = loginTF.text ?? ""
        let password = pswdTF.text ?? ""
        let findCurrentUser = CurrentUserService()
        let findTestUser = TestUserService()
        
        
#if DEBUG
        findTestUser.users = testUsers
        let user = findTestUser.searchLogin(login: login)
        vc.user = user
        print("\(vc.user?.fullName)")

        makeAuthorization(with: findTestUser)
        
#else
        findCurrentUser.users = users
        let user = findCurrentUser.searchLogin(login: login)
        
        vc.user = user
        print("\(vc.user?.fullName)")

        makeAuthorization(with: findCurrentUser)
        
#endif
        
        
        
        
        func  makeAuthorization (with service: UserServiceProtocol) {
            
            if service.isRightPassword(with: login, password: password) {
                print("Authorization was success")
                vc.modalPresentationStyle = .fullScreen
                loginButton.alpha = 1
                self.navigationController?.pushViewController(vc, animated: true)
            } else {
                let alertController = UIAlertController(title: "Ошибка", message: "Логин или пароль введен с ошибкой, попробуйте еще раз", preferredStyle: .alert)
                let ok = UIAlertAction(title: "Понятно", style:.cancel)
                
                loginTF.text = ""
                pswdTF.text = ""
                
                alertController.addAction(ok)
                self.present(alertController, animated: true)
            }
            
        }
        
        ////// TEST
        //    }
        //
        //    func makeSearch(with service: UserServiceProtocol ){
        //        let vc = ProfileViewController()
        //
        //        let login = loginTF.text ?? ""
        //        let password = pswdTF.text ?? ""
        //        vc.user = service.searchLogin(login: login)
        //        print(" --- \(vc.user?.fullName)")
        //        if service.isRightPassword(with: login, password: password) {
        //            print("Authorization was success")
        //            vc.modalPresentationStyle = .fullScreen
        //            loginButton.alpha = 1
        //            self.navigationController?.pushViewController(vc, animated: true)
        //        } else {
        //            let alertController = UIAlertController(title: "Ошибка", message: "Логин или пароль введен с ошибкой, попробуйте еще раз", preferredStyle: .alert)
        //            let ok = UIAlertAction(title: "Понятно", style:.cancel)
        //
        //            loginTF.text = ""
        //            pswdTF.text = ""
        //
        //            alertController.addAction(ok)
        //            self.present(alertController, animated: true)
        //        }
        //    }
        
        
    }
    
    
}


//
//
//findCurrentUser.users = users
//let user = findCurrentUser.searchLogin(login: login)
//vc.user = user
//print("\(vc.user?.fullName)")
//if findCurrentUser.isRightPassword(with: login, password: password) {
//    print("Authorization was success")
//    vc.modalPresentationStyle = .fullScreen
//    loginButton.alpha = 1
//    self.navigationController?.pushViewController(vc, animated: true)
//} else {
//    let alertController = UIAlertController(title: "Ошибка", message: "Логин или пароль введен с ошибкой, попробуйте еще раз", preferredStyle: .alert)
//    let ok = UIAlertAction(title: "Понятно", style:.cancel)
//
//    loginTF.text = ""
//    pswdTF.text = ""
//
//    alertController.addAction(ok)
//    self.present(alertController, animated: true)
//}
