//
//  ProfileTableHeaderView.swift
//  Navigation
//
//  Created by Krime Loma    on 8/14/22.
//

import Foundation
import UIKit

class ProfileTableHeaderView: UITableViewHeaderFooterView {
    
    private lazy var profileHeaderView : ProfileHeaderView = {
        let view = ProfileHeaderView(frame: .zero)
        view.backgroundColor = .systemGray6
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setViews () {
        self.addSubview(self.profileHeaderView)
    }
    
    private func setConstraints () {
        
        NSLayoutConstraint.activate([
            
            self.profileHeaderView.topAnchor.constraint(equalTo: self.topAnchor),
            self.profileHeaderView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.profileHeaderView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.profileHeaderView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
