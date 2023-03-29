//
//  DrawerView.swift
//  Navigation
//
//  Created by Kiryl Rakk on 17/3/23.
//

import UIKit
import SnapKit

class DrawerView: UIView {
    
    static var menuItems = ["Сохранить в закладках" , "Включить уведомления", "Скопировать ссылку", "Поделиться в...", "Отменить подписку", "Пожаловаться"]
    
    
    private lazy var lineView: UIView = {
        var view = UIView()
        view.backgroundColor = .black
        return view
    }()
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.rowHeight = UITableView.automaticDimension
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.delegate = self
        table.dataSource = self
        table.backgroundColor = .systemGray5
        table.separatorStyle = .none
        return table
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor  = .systemGray5
        setViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setViews() {
        self.addSubview(lineView)
        lineView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(30)
            make.width.equalTo(50)
            make.height.equalTo(2)
            make.centerX.equalToSuperview()
        }
        self.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(lineView.snp.bottom).offset(16)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}

extension DrawerView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        DrawerView.menuItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = DrawerView.menuItems[indexPath.row]
        cell.textLabel?.font = UIFont(name: "Inter-Regular", size: 14)
        cell.backgroundColor = .systemGray5
        return cell
    }
}
