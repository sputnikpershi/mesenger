//
//  LaunchScreenViewController.swift
//  Navigation
//
//  Created by Kiryl Rakk on 16/10/22.
//

import UIKit

class ScreenViewController: UIViewController {
    
    private var timer: Timer?
    private var durationTimer = 10
    
    private lazy var backGroundImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "screen")
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = label.font.withSize(25)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var logoImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "vk_white")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var timerLabel: UILabel = {
        let label = UILabel()
        label.text = "\(durationTimer)"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    } ()
    
    private lazy var timerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Пропустить", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        return button
    } ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timetAction), userInfo: nil, repeats: true)
        descriptionLabel.text = "Какое-то основное описание функционала или призыв сделать что-то"
        setLayout()
        setConstraints()
        setAnimation()
    }
    
    @objc private func timetAction () {
        durationTimer -= 1
        timerLabel.text = "\(durationTimer)"
        print(durationTimer)
        if durationTimer == 0 {
            didTapButton ()
        }
    }
    
    
    @objc private func didTapButton () {
        timer?.invalidate()
        navigationController?.pushViewController(LogInViewController(), animated: false)
    }
    
    
    private func setLayout () {
        self.view.addSubview(self.backGroundImage)
        self.view.addSubview(self.timerButton)
        self.view.addSubview(self.descriptionLabel)
        self.view.addSubview(self.timerLabel)
        self.view.addSubview(self.logoImage)
        
    }
    
    
    private func setConstraints () {
        NSLayoutConstraint.activate([
            
            self.backGroundImage.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.backGroundImage.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.backGroundImage.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.backGroundImage.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            
            self.logoImage.centerYAnchor.constraint(equalTo:  self.view.centerYAnchor, constant: -50),
            self.logoImage.centerXAnchor.constraint(equalTo:   self.view.centerXAnchor),
            self.logoImage.widthAnchor.constraint(equalToConstant: 100),
            self.logoImage.heightAnchor.constraint(equalToConstant: 100),
            
            self.descriptionLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.descriptionLabel.topAnchor.constraint(equalTo: logoImage.bottomAnchor),
            self.descriptionLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.7),
            
            self.timerButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -35),
            self.timerButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant:  -25),
            
            self.timerLabel.bottomAnchor.constraint(equalTo: timerButton.topAnchor),
            self.timerLabel.trailingAnchor.constraint(equalTo: timerButton.trailingAnchor, constant: -50),
        ])
    }
    
    
    private func setAnimation() {
        logoImage.transform = CGAffineTransform(scaleX: 100, y: 100)
        UIView.animate(withDuration: 3, delay: 0) {
            self.logoImage.transform = .identity
            
        }
    }
}
