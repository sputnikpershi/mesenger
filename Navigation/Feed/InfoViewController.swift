//
//  InfoViewController.swift
//  Navigation
//
//  Created by Krime Loma    on 7/25/22.
//

import UIKit

class InfoViewController: UIViewController {
    
    
    private lazy var alertButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        button.backgroundColor = .lightGray
        button.setTitle("Check", for: .normal)
        button.addTarget(self, action: #selector(didTapButtonAlert), for: .touchUpInside)
        return button
    } ()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.alertButton)
        self.view.backgroundColor = .systemYellow
        self.alertButton.center = self.view.center
        self.alertButton.layer.cornerRadius = 10
    }
    
    
    @objc private func didTapButtonAlert () {
        let alertController = UIAlertController(title: "", message: "Which tablet you prefer?", preferredStyle: .alert)
        let blueAction  = UIAlertAction(title: "Blue", style: .cancel) { _ in print("Neo chosed a blue tablet")
        }
        let redAction  = UIAlertAction(title: "Red", style: .destructive) { _ in print("Neo chosed a red tablet")
        }
        alertController.addAction(blueAction)
        alertController.addAction(redAction)
        self.present(alertController, animated: true)

    }
}
