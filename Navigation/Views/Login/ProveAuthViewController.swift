//
//  ProveAuthViewController.swift
//  Navigation
//
//  Created by Kiryl Rakk on 28/3/23.
//

import UIKit
import SnapKit
import Combine

class ProveAuthViewController: UIViewController {
    var isRegistration: Bool?
    var number : String?

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Подтверждение регистрации"
        label.font = UIFont(name: "Inter-SemiBold", size: 18)
        label.textColor = .orange
        return label
    }()
   
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = UIColor(red: 0.495, green: 0.507, blue: 0.512, alpha: 1)
        label.font = UIFont(name: "Inter-Regular", size: 14)
        label.text = "Мы отправили SMS с кодом на номер"
        return label
    }()
    
    private lazy var phoneLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .black
        label.font = UIFont(name: "Inter-Regular", size: 16)
        label.text = number
        return label
    }()
    
    private lazy var actionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = UIColor(red: 0.495, green: 0.507, blue: 0.512, alpha: 1)
        label.font = UIFont(name: "Inter-Regular", size: 12)
        label.text = "Введите код из SMS"
        return label
    }()
    
    private lazy var tfView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.layer.borderColor = UIColor(ciColor: .black).cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    private lazy var textField: UITextField = {
       let tf = UITextField()
//        tf.delegate = self
        tf.keyboardType = .asciiCapableNumberPad
        tf.textContentType = .telephoneNumber
        tf.placeholder = "_ _-_ _-_ _"
        return tf
    }()
    
  
    
    
    private lazy var authButton : UIButton = {
        let button = UIButton()
        button.setTitle(" ЗАРЕГИСТРИРОВАТЬСЯ ", for: .normal)
        button.layer.cornerRadius = 10
        button.backgroundColor = UIColor(red: 0.17, green: 0.223, blue: 0.25, alpha: 1)
        button.addTarget(self, action: #selector(tapButtonAction), for: .touchUpInside)
        return button
    }()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setGesture()
        view.backgroundColor = .white
        setLayers()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "arrow1"), style: .plain, target: self, action: #selector(didTapBackButtonAction))
        navigationController?.navigationBar.tintColor = .black
        configureViews()
    }
    
    @objc func didTapBackButtonAction () {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func tapButtonAction () {
            if let text = textField.text, !text.isEmpty {
                let code = text
                
                AuthManager.shared.verifySMS(smsCode: code) { success in
                    guard success else { return }
print("success")
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "dissmis"), object: nil)

                }
            }
    }
    
    private func  configureViews() {
        if isRegistration! == false {
            titleLabel.text = "Подтверждение авторизации"
            authButton.setTitle("ПОДТВЕРДИТЬ", for: .normal)
        }
    }

    
    
    private func setLayers() {
        self.view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(180)
            make.centerX.equalToSuperview()
        }
        self.view.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(12)
            make.width.equalTo(180)
            make.centerX.equalToSuperview()
        }
        self.view.addSubview(phoneLabel)
        phoneLabel.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(12)
            make.width.equalTo(180)
            make.centerX.equalToSuperview()
        }
        
        
        self.view.addSubview(tfView)
        tfView.snp.makeConstraints { make in
            make.top.equalTo(phoneLabel.snp.bottom).offset(138)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().inset(116)
            make.height.equalTo(50)
        }
        self.view.addSubview(actionLabel)
        actionLabel.snp.makeConstraints { make in
            make.bottom.equalTo(tfView.snp.top).offset(-12)
            make.leading.equalTo(tfView.snp.leading)
        }
        
        self.view.addSubview(textField)
        textField.snp.makeConstraints { make in
            make.top.bottom.equalTo(tfView)
            make.centerX.equalTo(self.tfView)

        }
        
        self.view.addSubview(authButton)
        authButton.snp.makeConstraints { make in
            make.top.equalTo(tfView.snp.bottom).offset(86)
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
        }
    }
    
    private  func setGesture () {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
            self.view.addGestureRecognizer(tapGesture)
        }
        @objc private func hideKeyboard () {
            self.view.endEditing(true )
        }
    
}

//extension ProveAuthViewController: UITextFieldDelegate {
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        textField.resignFirstResponder()
//
//        if let text = textField.text, !text.isEmpty {
//            let code = text
//
//            AuthManager.shared.verifySMS(smsCode: code) { success in
//                guard success else { return }
//                DispatchQueue.main.async {
//                    print("activate")
//                }
//            }
//        }
//        return true
//    }
//}
