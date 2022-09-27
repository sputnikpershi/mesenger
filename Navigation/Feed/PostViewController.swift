//
//  PostViewController.swift
//  Navigation
//
//  Created by Krime Loma    on 7/25/22.
//

import UIKit

class PostViewController: UIViewController {

    var postTitle : String?
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 100))
        label.textAlignment = .center
        label.text = "Text"
        label.textColor = .white
        label.font = label.font.withSize(25)
        return label
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .orange
        if let postTitle = postTitle { titleLabel.text = postTitle }
        let barButton = UIBarButtonItem(title: "Details", style: .plain, target: self, action: #selector(self.didSelectedButton))
        self.navigationItem.rightBarButtonItem = barButton
        self.view.addSubview(self.titleLabel)
        self.titleLabel.center = self.view.center
    }

    
    @objc private func didSelectedButton() {
      let vc = InfoViewController()
        self.present(vc, animated: true)
    }
}
