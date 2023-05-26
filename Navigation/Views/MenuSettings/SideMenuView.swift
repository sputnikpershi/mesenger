//
//  SideMenuInfo.swift
//  Navigation
//
//  Created by Kiryl Rakk on 15/3/23.
//

import UIKit

enum SideMenuState {
    case opened
    case closed
}


class SideMenuView: UIView {
    var view : UIViewController?
    var state: StateMenu?
    var title: String?
    
    private lazy var stackView: UIStackView =  {
        let stack = UIStackView ()
        stack.axis = .vertical
        stack.backgroundColor = .systemGray6
        return stack
    }()
    private lazy var backButton: UIButton =  {
        let button = UIButton ()
        button.setImage(UIImage(named: "arrow1"), for: .normal)
        button.addTarget(self, action: #selector(didTapBackButtonAction), for: .touchUpInside)
        return button
    }()
    
    private lazy var nameLabel: UILabel = {
        let name = UILabel(frame: CGRect(x: 0, y: 0, width: 0 , height: 0 ))
        name.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        name.textColor = UIColor.createColor(lightMode: .black, darkMode: .white)
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()
    
    private lazy var separatorHorizontal : UIView = {
        let line = UIView()
        line.backgroundColor = UIColor(red: 0.495, green: 0.507, blue: 0.512, alpha: 1)
        return line
    } ()
    
    private lazy var separatorTableHorizontal : UIView = {
        let line = UIView()
        line.backgroundColor = UIColor(red: 0.495, green: 0.507, blue: 0.512, alpha: 1)
        return line
    } ()
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.register(SideMenuTableCell.self, forCellReuseIdentifier: "cell")
        table.register(SideInfoTableCell.self, forCellReuseIdentifier: "cell info")
        table.estimatedRowHeight = UITableView.automaticDimension
        table.backgroundColor = nil
        table.separatorStyle = .none
        table.dataSource = self
        table.delegate = self
        return table
    }()
    
    private lazy var settingsButton : UIButton = {
        let button = UIButton()
        button.setTitle("  Настройки", for: .normal)
        button.titleLabel?.font = UIFont(name: "Inter-Regular", size: 14)
        button.setImage(UIImage(systemName: "gearshape"), for: .normal)
        button.imageView?.tintColor = .orange
        button.setTitleColor(UIColor.createColor(lightMode: .black, darkMode: .white), for: .normal)
        return button
    } ()
    
    init(state: StateMenu, title: String) {
        self.state = state
        self.title = title
        super.init(frame: .zero)
        setLayers()
        stackView.backgroundColor = .systemGray6
        confugureView()
        }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func confugureView() {
        if state == .menuAction {
            nameLabel.text = "Profile"
        } else {
            nameLabel.text = title
        }
    }
    
    func setLayers() {
        self.addSubview(stackView)
        stackView.addArrangedSubview(backButton)
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(separatorHorizontal)
        stackView.addArrangedSubview(tableView)
        
        stackView.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.top.equalToSuperview()
            make.width.equalTo(300)
            make.bottom.equalToSuperview()
        }
        self.addSubview(backButton)
        backButton.snp.makeConstraints { make in
            make.leading.equalTo(stackView.snp.leading).offset(30)
            make.top.equalTo(stackView.snp.top).offset(58)
        }
        self.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(backButton.snp.bottom).offset(25)
            make.leading.equalTo(stackView.snp.leading).offset(30)
        }
        self.addSubview(separatorHorizontal)
        separatorHorizontal.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(15)
            make.leading.equalTo(stackView.snp.leading).offset(30)
            make.height.equalTo(0.5)
            make.trailing.equalTo(stackView.snp.trailing).offset(-26)
        }
        
        if state == .menuAction {
            stackView.addArrangedSubview(tableView)
            stackView.addArrangedSubview(settingsButton)
            stackView.addArrangedSubview(separatorTableHorizontal)
            self.addSubview(tableView)
            tableView.snp.makeConstraints { make in
                make.top.equalTo(separatorHorizontal.snp.bottom).offset(16)
                make.trailing.equalTo(stackView.snp.trailing).offset(-26)
                make.leading.equalTo(stackView.snp.leading).offset(30)
                make.height.equalTo(160)
            }
            self.addSubview(separatorTableHorizontal)
            separatorTableHorizontal.snp.makeConstraints { make in
                make.top.equalTo(tableView.snp.bottom).offset(8)
                make.leading.equalTo(stackView.snp.leading).offset(30)
                make.height.equalTo(0.5)
                make.trailing.equalTo(stackView.snp.trailing).offset(-26)
            }
            self.addSubview(settingsButton)
            settingsButton.snp.makeConstraints { make in
                make.top.equalTo(separatorTableHorizontal.snp.bottom).offset(8)
                make.leading.equalTo(stackView.snp.leading).offset(30)
                
            }
        } else {
            self.addSubview(tableView)
            tableView.snp.makeConstraints { make in
                make.top.equalTo(separatorHorizontal.snp.bottom).offset(16)
                make.trailing.equalTo(stackView.snp.trailing).offset(-26)
                make.leading.equalTo(stackView.snp.leading).offset(30)
                make.height.equalTo(170)
            }
        }
    }
    
    @objc func didTapBackButtonAction() {
            self.removeFromSuperview()
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
        }
}


extension SideMenuView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return state == .menuAction ?  4 :  5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if state == .menuAction {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SideMenuTableCell
            cell.setCell(text: MenuButtons.allCases[indexPath.row].rawValue, image: MenuButtons.allCases[indexPath.row].image)
            cell.backgroundColor = .systemGray6
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell info", for: indexPath) as! SideInfoTableCell
            cell.setCell(text: MenuButtons.allCases[indexPath.row + 4].rawValue)
            cell.backgroundColor = .systemGray6
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
}
