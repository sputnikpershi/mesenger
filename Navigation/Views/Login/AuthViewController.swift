//
//  AuthViewController.swift
//  Navigation
//
//  Created by Kiryl Rakk on 28/3/23.
//

import UIKit
import SnapKit

class AuthViewController: UIViewController {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "С возвращением"
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
        label.text = "Введите номер телефона для входа в приложение"
        return label
    }()
    
    private lazy var tfView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.layer.borderColor = UIColor(ciColor: .black).cgColor
        view.layer.borderWidth = 1
        return view
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
    
    private lazy var textField: UITextField = {
       let tf = UITextField()
//        tf.delegate = self
        tf.keyboardType = .asciiCapableNumberPad
        tf.textContentType = .telephoneNumber
        tf.placeholder = "_ _ _-_ _ _-_ _-_ _"
        tf.textColor  = .black
        return tf
    }()
    
    private lazy var authButton : UIButton = {
        let button = UIButton()
        button.setTitle("ПОДТВЕРДИТЬ", for: .normal)
        button.layer.cornerRadius = 10
        button.backgroundColor = UIColor(red: 0.17, green: 0.223, blue: 0.25, alpha: 1)
        button.addTarget(self, action: #selector(proveAction), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setGesture()
        view.backgroundColor = .white
        setLayers()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "arrow1"), style: .plain, target: self, action: #selector(didTapBackButtonAction))
        navigationController?.navigationBar.tintColor = .black
    }
  
    @objc func didTapBackButtonAction () {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func proveAction () {
        
        if let text = textField.text, !text.isEmpty {
            let number = "+7\(text)"
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
                    vc.isRegistration = false
                    vc.number = number
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
            
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
            make.top.equalTo(titleLabel.snp.bottom).offset(26)
            make.width.equalTo(180)
            make.centerX.equalToSuperview()
        }
        self.view.addSubview(tfView)
        tfView.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(12)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().inset(116)
            make.height.equalTo(50)
        }
        self.view.addSubview(sevenLabel)
        sevenLabel.snp.makeConstraints { make in
            make.trailing.equalTo(tfView.snp.leading).offset(-4)
            make.centerY.equalTo(tfView.snp.centerY)
        }
        
        self.view.addSubview(textField)
        textField.snp.makeConstraints { make in
            make.top.bottom.equalTo(tfView)
            make.centerX.equalTo(self.tfView)

        }
        
        self.view.addSubview(authButton)
        authButton.snp.makeConstraints { make in
            make.top.equalTo(tfView.snp.bottom).offset(148)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().offset(-188)
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
//
//extension AuthViewController : UITextFieldDelegate {
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        textField.resignFirstResponder()
//
//        if let text = textField.text, !text.isEmpty {
//            let number = "+7\(text)"
//            AuthManager.shared.startAuth(phoneNumber: number) { success in
//                guard success else { return }
//                DispatchQueue.main.async {
//                    print("activate")
//                }
//            }
//
//        }
//        return true
//    }
//}
