//
//  MenuCell.swift
//  Navigation
//
//  Created by Kiryl Rakk on 3/3/23.
//

import UIKit
import SnapKit

class MenuBarCell: UICollectionViewCell {
    static var buttons = ["Новости", "Для вас"]
    
     var titleLabel: UILabel = {
        let title = UILabel()
         title.text = "Some button"
        title.font = UIFont(name: "Inter-Regular", size: 14)
        return title
    }()
    
     var indocatorLine: UIView = {
        let line = UIView()
        line.backgroundColor = .orange
        return line
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayers()
    }
   
    
    func setLayers() {
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        self.addSubview(indocatorLine)
        indocatorLine.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.width.equalTo(titleLabel.snp.width)
            make.centerX.equalTo(titleLabel.snp.centerX)
            make.height.equalTo(1)
        }
    }

    func setLabels(index: Int) {
        titleLabel.text = MenuBarCell.buttons[index]
       
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                titleLabel.textColor = .black
                indocatorLine.alpha = 1
            } else {
                titleLabel.textColor = UIColor(red: 0.495, green: 0.507, blue: 0.512, alpha: 1)
                indocatorLine.alpha = 0
            }
        }
    }
    override var isHighlighted: Bool {
        didSet {
            if isSelected {
                titleLabel.textColor = .black
                indocatorLine.alpha = 1
            } else {
                titleLabel.textColor = UIColor(red: 0.495, green: 0.507, blue: 0.512, alpha: 1)
                indocatorLine.alpha = 0
            }
        }
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
