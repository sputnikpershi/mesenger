//
//  EditMenuViewController.swift
//  Navigation
//
//  Created by Kiryl Rakk on 10/3/23.
//

import UIKit
import SnapKit

class EditMenuViewController: UIViewController {
    
    var isFemale: Bool?
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Inter-Medium", size: 12)
        label.text = "Имя"
        return label
    }()
    
    private lazy var nameTextField: UITextField = {
        let tf = UITextField()
        tf.backgroundColor = UIColor(red: 0.961, green: 0.953, blue: 0.933, alpha: 1)
        tf.layer.cornerRadius = 10
        tf.placeholder  = "имя"
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: 0))
        tf.leftView = paddingView
        tf.leftViewMode = UITextField.ViewMode.always
        return tf
    }()
    
    private lazy var surnameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Inter-Medium", size: 12)
        label.text = "Фамилия"
        return label
    }()
    
    private lazy var surnameTextField: UITextField = {
        let tf = UITextField()
        tf.layer.cornerRadius = 10
        tf.placeholder  = "фамилия"
        tf.backgroundColor = UIColor(red: 0.961, green: 0.953, blue: 0.933, alpha: 1)
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: 0))
        tf.leftView = paddingView
        tf.leftViewMode = UITextField.ViewMode.always
        return tf
    }()

    private lazy var sexLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Inter-Medium", size: 12)
        label.text = "Пол"
        return label
    }()
    
    private lazy var maleButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont(name: "Inter-Regular", size: 14)
        button.setTitle("мужской", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.setImage(UIImage(systemName: "circle"), for: .normal)
        button.contentHorizontalAlignment = .leading
        button.addTarget(self, action: #selector(tapedSexButton), for: .touchUpInside)
        return button
    }()
    private lazy var femaleButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont(name: "Inter-Regular", size: 14)
        button.setTitle("женский", for: .normal)
        button.setImage(UIImage(systemName: "record.circle"), for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.contentHorizontalAlignment = .leading
        button.addTarget(self, action: #selector(tapedSexButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var birthLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Inter-Medium", size: 12)
        label.text = "Дата рождения"
        return label
    }()
    
    private lazy var birthTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder  = "01.01.2020"
        tf.backgroundColor = UIColor(red: 0.961, green: 0.953, blue: 0.933, alpha: 1)
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: 0))
        tf.leftView = paddingView
        tf.layer.cornerRadius = 10
        tf.leftViewMode = UITextField.ViewMode.always
        return tf
    }()
    
    private lazy var cityLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Inter-Medium", size: 12)
        label.text = "Родной город"
        return label
    }()
    
    private lazy var cityTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Напишите название"
        tf.backgroundColor = UIColor(red: 0.961, green: 0.953, blue: 0.933, alpha: 1)
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: 0))
        tf.leftView = paddingView
        tf.layer.cornerRadius = 10
        tf.leftViewMode = UITextField.ViewMode.always
        return tf
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Основная информация"
        view.backgroundColor = .white
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "cancel1"), style: .plain, target: self, action: #selector(tapedCancelActionButton))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "check2"), style: .plain, target: self, action: #selector(tapedSaveMenuActionButton))

        self.navigationController?.navigationBar.tintColor = .orange
        setLayers()
        configureButton()
    }
    
    @objc func tapedSexButton() {
        if femaleButton.currentImage == UIImage(systemName: "circle") {
            femaleButton.setImage(UIImage(systemName: "record.circle"), for: .normal)
            maleButton.setImage(UIImage(systemName: "circle"), for: .normal)

            isFemale = true
        } else {
            femaleButton.setImage(UIImage(systemName: "circle"), for: .normal)
            maleButton.setImage(UIImage(systemName: "record.circle"), for: .normal)
            isFemale = false
        }
        print(String(describing: isFemale))
    }
    
    private func setLayers() {
        self.view.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(8)
            make.leading.equalToSuperview().offset(24)
        }
        self.view.addSubview(nameTextField)
        nameTextField.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(6)
            make.leading.equalTo(nameLabel.snp.leading)
            make.height.equalTo(40)
            make.trailing.equalToSuperview().offset(-16)
        }
        self.view.addSubview(surnameLabel)
        surnameLabel.snp.makeConstraints { make in
            make.top.equalTo(nameTextField.snp.bottom).offset(14)
            make.leading.equalTo(nameTextField.snp.leading)
            make.trailing.equalToSuperview().offset(-16)
        }
        self.view.addSubview(surnameTextField)
        surnameTextField.snp.makeConstraints { make in
            make.top.equalTo(surnameLabel.snp.bottom).offset(6)
            make.leading.equalTo(surnameLabel.snp.leading)
            make.height.equalTo(40)
            make.trailing.equalToSuperview().offset(-16)
        }
        self.view.addSubview(sexLabel)
        sexLabel.snp.makeConstraints { make in
            make.top.equalTo(surnameTextField.snp.bottom).offset(14)
            make.leading.equalTo(surnameTextField.snp.leading)
            make.trailing.equalToSuperview().offset(-16)
        }
        self.view.addSubview(maleButton)
        maleButton.snp.makeConstraints { make in
            make.top.equalTo(sexLabel.snp.bottom).offset(11)
            make.leading.equalTo(sexLabel.snp.leading)
            make.trailing.equalToSuperview().offset(-16)
        }
        self.view.addSubview(femaleButton)
        femaleButton.snp.makeConstraints { make in
            make.top.equalTo(maleButton.snp.bottom).offset(11)
            make.leading.equalTo(maleButton.snp.leading)
            make.trailing.equalToSuperview().offset(-16)
        }
        self.view.addSubview(birthLabel)
        birthLabel.snp.makeConstraints { make in
            make.top.equalTo(femaleButton.snp.bottom).offset(34)
            make.leading.equalTo(femaleButton.snp.leading)
            make.trailing.equalToSuperview().offset(-16)
        }
        self.view.addSubview(birthTextField)
        birthTextField.snp.makeConstraints { make in
            make.top.equalTo(birthLabel.snp.bottom).offset(6)
            make.leading.equalTo(birthLabel.snp.leading)
            make.height.equalTo(40)
            make.trailing.equalToSuperview().offset(-16)
        }
        self.view.addSubview(cityLabel)
        cityLabel.snp.makeConstraints { make in
            make.top.equalTo(birthTextField.snp.bottom).offset(14)
            make.leading.equalTo(birthTextField.snp.leading)
            make.trailing.equalToSuperview().offset(-16)
        }
        self.view.addSubview(cityTextField)
        cityTextField.snp.makeConstraints { make in
            make.top.equalTo(cityLabel.snp.bottom).offset(6)
            make.leading.equalTo(cityLabel.snp.leading)
            make.height.equalTo(40)
            make.trailing.equalToSuperview().offset(-16)
        }
    }

    private func configureButton() {
        if isFemale! {
            femaleButton.setImage(UIImage(systemName: "record.circle"), for: .normal)
            maleButton.setImage(UIImage(systemName: "circle"), for: .normal)
        } else {
            femaleButton.setImage(UIImage(systemName: "circle"), for: .normal)
            maleButton.setImage(UIImage(systemName: "record.circle"), for: .normal)
        }
    }
    
    @objc func tapedSaveMenuActionButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func tapedCancelActionButton() {
        self.navigationController?.popViewController(animated: true)
    }
}
