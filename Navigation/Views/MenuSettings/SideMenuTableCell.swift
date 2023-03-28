//
//  SideMenuTableCell.swift
//  Navigation
//
//  Created by Kiryl Rakk on 14/3/23.
//

import UIKit
import SnapKit

class SideMenuTableCell: UITableViewCell {
    
    var state: StateMenu?
    var isMenu: Bool?
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
        self.addSubview(cellImage)
        self.addSubview(cellLabel)
        cellImage.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalToSuperview().offset(8)
            make.height.width.equalTo(24)
            make.bottom.equalToSuperview().offset(-8)
        }
        cellLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.bottom.equalToSuperview().offset(-8)
            make.leading.equalTo(cellImage.snp.trailing).offset(8)
        }
    }
    
    func setCell(text: String, image: String) {
        cellLabel.text = text
        cellImage.image = UIImage(systemName: image)
    }
}
