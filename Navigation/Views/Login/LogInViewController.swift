//
//  AuthViewController.swift
//  Navigation
//
//  Created by Kiryl Rakk on 28/3/23.
//

import UIKit
import SnapKit

class LogInViewController: UIViewController {
    
    
    private lazy var viewImage: UIImageView  = {
        let image = UIImageView()
        image.image = UIImage(named: "auth1")
        return image
    }()
    
    private lazy var registerButton : UIButton = {
        let button = UIButton()
        button.setTitle("Зарегистрировать", for: .normal)
        button.layer.cornerRadius = 10
        button.backgroundColor = UIColor(red: 0.17, green: 0.223, blue: 0.25, alpha: 1)
        button.addTarget(self, action: #selector(registrationAction), for: .touchUpInside)
        return button
    }()
    private lazy var authButton : UIButton = {
        let button = UIButton()
        button.setTitle("Уже есть аккаунт", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(authAction), for: .touchUpInside)

        return button
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayers()
        view.backgroundColor = .white
    }
    
    
    @objc func  registrationAction () {
        let vc = RegistrationViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func authAction () {
        let vc = AuthViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func setLayers() {
        self.view.addSubview(viewImage)
        viewImage.snp.makeConstraints { make in
            make.width.equalToSuperview().offset(30)
            make.centerX.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.height.equalTo(viewImage.snp.width)
        }
        self.view.addSubview(registerButton)
        registerButton.snp.makeConstraints { make in
            make.top.equalTo(viewImage.snp.bottom).offset(80)
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
            make.width.equalToSuperview().inset(114)
        }
        
        self.view.addSubview(authButton)
        self.authButton.snp.makeConstraints { make in
            make.top.equalTo(registerButton.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
            
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
