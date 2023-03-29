//
//  PopupMenuCell.swift
//  Navigation
//
//  Created by Kiryl Rakk on 10/3/23.
//

import UIKit
import SnapKit


class PopupMenuCell: UICollectionViewCell {
    static let identifier = "PopupMenuCell"
    let names = ["Сохранить в закладках", "Закрепить", "Выключить комментирование", "Скопировать ссылку", "Архивировать запись", "Удалить"]
    
    private lazy var settingButton : UILabel = {
        let label = UILabel()
        label.textColor = UIColor.createColor(lightMode: .black, darkMode: .orange)
        label.font = UIFont(name: "Inter-Regular", size: 14)
        return label
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(settingButton)
        settingButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(18)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setCell(index: Int) {
        settingButton.text = names[index]
    }
}
