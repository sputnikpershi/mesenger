//
//  SideInfoTableCell.swift
//  Navigation
//
//  Created by Kiryl Rakk on 15/3/23.
//

import UIKit

class SideInfoTableCell: UITableViewCell {
    private lazy var cellImage: UIImageView = {
        let image = UIImageView()
        image.tintColor = .orange
        return   image
    }()
    
    private lazy var cellLabel: UILabel = {
        let label = UILabel()
        label.text = "Text"
        label.font = UIFont(name: "Inter-Regular", size: 14)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setLayers()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setLayers() {
        self.addSubview(cellLabel)
        
        cellLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.bottom.equalToSuperview().offset(-8)
            make.leading.equalToSuperview()
        }
    }
    
    func setCell(text: String) {
        cellLabel.text = text
    }
}

