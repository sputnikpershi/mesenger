//
//  RegistrationViewController.swift
//  Navigation
//
//  Created by Kiryl Rakk on 28/3/23.
//

import UIKit
import SnapKit

class RegistrationViewController: UIViewController {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "ЗАРЕГИСТРИРОВАТЬСЯ"
        label.font = UIFont(name: "Inter-SemiBold", size: 18)
        return label
    }()
    
    private lazy var placeholderLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Inter-Medium", size: 16)
        label.textColor = UIColor(red: 0.851, green: 0.851, blue: 0.851, alpha: 1)
        label.text = "Введите номер"
        return label
    }()
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = UIColor(red: 0.495, green: 0.507, blue: 0.512, alpha: 1)
        label.font = UIFont(name: "Inter-Medium", size: 12)
        label.text = "Ваш номер будет использоваться для входа в аккаунт"
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
        tf.keyboardType = .asciiCapableNumberPad
        tf.textContentType = .telephoneNumber
        tf.placeholder = "_ _ _-_ _ _-_ _-_ _"
        tf.textColor  = .black
        return tf
    }()
    
    
    private lazy var policyLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = "Нажимая кнопку “Далее” Вы принимаете пользовательское Соглашение и политику конфедициальности"
        label.textColor = UIColor(red: 0.495, green: 0.507, blue: 0.512, alpha: 1)
        label.font = UIFont(name: "Inter-Medium", size: 12)
        return label
    }()
    private lazy var sevenLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = UIColor(red: 0.495, green: 0.507, blue: 0.512, alpha: 1)
        label.font = UIFont(name: "Inter-Regular", size: 14)
        label.text = "+7"
        return label
    }()
    
    private lazy var registerButton : UIButton = {
        let button = UIButton()
        button.setTitle("Далее", for: .normal)
        button.layer.cornerRadius = 10
        button.backgroundColor = UIColor(red: 0.17, green: 0.223, blue: 0.25, alpha: 1)
        button.addTarget(self, action: #selector(nextAction), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setGesture()
        view.backgroundColor = .white
        setLayers()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "arrow1"), style: .plain, target: self, action: #selector(didTapBackButtonAction))
        navigationController?.navigationBar.tintColor = .black
        // Do any additional setup after loading the view.
    }
    
    @objc func didTapBackButtonAction () {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func nextAction() {
        
        if let text = textField.text, !text.isEmpty {
            let number = "+7\(AuthManager.number)"
            let fakeNumber = "+7\(text)"
            AuthManager.shared.startAuth(phoneNumber: number) { success in
                guard success else {
                    
                    let alert = UIAlertController(title: "Error", message: "Такого номера нет в базе. Хотите зарегистрироваться?", preferredStyle: .alert)
                    let cancel = UIAlertAction(title: "Отмена", style: .cancel)
                    let registration = UIAlertAction(title: "Зарегистрироваться", style: .default)
                    alert.addAction(cancel)
                    alert.addAction(registration)
                    self.present(alert, animated: true)
                    return }
                DispatchQueue.main.async {
                    let vc = SMSViewController()
                    vc.isRegistration = true
                    vc.number = fakeNumber
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
        }
    }
    

    private func setLayers() {
        self.view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(60)
            make.centerX.equalToSuperview()
        }
        
        self.view.addSubview(placeholderLabel)
        placeholderLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(70)
            make.centerX.equalToSuperview()
        }
        
        self.view.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(placeholderLabel.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
            make.width.equalTo(215)

        }
        
        self.view.addSubview(tfView)
        tfView.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(23)
            make.width.equalToSuperview().inset(116)
            make.height.equalTo(50)
            make.centerX.equalToSuperview()
        }
        
        self.view.addSubview(sevenLabel)
        sevenLabel.snp.makeConstraints { make in
            make.trailing.equalTo(tfView.snp.leading).offset(-4)
            make.centerY.equalTo(tfView.snp.centerY)
        }
        self.view.addSubview(registerButton)
        registerButton.snp.makeConstraints { make in
            make.top.equalTo(tfView.snp.bottom).offset(60)
            make.height.equalTo(50)
            make.width.equalToSuperview().inset(114)
            make.centerX.equalToSuperview()
        }
        self.view.addSubview(policyLabel)
        policyLabel.snp.makeConstraints { make in
            make.top.equalTo(registerButton.snp.bottom).offset(30)
            make.width.equalTo(256)
            make.centerX.equalToSuperview()
        }
        self.view.addSubview(textField)
        textField.snp.makeConstraints { make in
            make.top.bottom.equalTo(self.tfView)
//            make.width.equalTo(self.tfView).offset(30)
            make.centerX.equalTo(self.tfView)
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
