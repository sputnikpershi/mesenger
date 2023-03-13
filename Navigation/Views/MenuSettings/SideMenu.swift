//
//  SideMenu.swift
//  Navigation
//
//  Created by Kiryl Rakk on 13/3/23.
//

import UIKit


class SideMenu: NSObject {
    let blackView = UIView()
    var view : UIViewController?
    var isEnableSideBar = false
    
    private lazy var sideMenu: UIView = {
        let menu = UIView()
        menu.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        menu.layer.shadowRadius = 10
        menu.backgroundColor = .white
        return menu
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "arrow1"), for: .normal)
        return button
    }()
    
    
    override init() {
        super.init()
    }
    
    func showMenu() {
        blackView.backgroundColor = .black
        blackView.alpha = 0
        blackView.frame = (self.view?.view.frame)!
        sideMenu.frame =  CGRect(x: (self.view?.view.frame.width)!, y: 0, width:0, height: (self.view?.view.frame.height)!)

        if isEnableSideBar {
            UIView.animate(withDuration: 0.5, delay: 0) {
                self.sideMenu.frame = CGRect(x: (self.view?.view.frame.width)!, y: 0, width: (self.view?.view.frame.width)! - 70, height: (self.view?.view.frame.height)!)
                self.blackView.alpha = 0
            }
            isEnableSideBar = false
        } else {
            view?.view.addSubview(blackView)
            view?.view.addSubview(sideMenu)
            UIView.animate(withDuration: 1, delay: 0) {
                self.blackView.alpha = 0.3
                self.sideMenu.frame = CGRect(x: 70, y: 0, width: (self.view?.view.frame.width)! - 70, height: (self.view?.view.frame.height)!)
             
            }
            
              isEnableSideBar = true
        }
    }
    
}
