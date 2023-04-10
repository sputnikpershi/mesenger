//
//  DarkMode.swift
//  Navigation
//
//  Created by Kiryl Rakk on 30/3/23.
//

import UIKit

let colorButtonText = UIColor.createColor(lightMode: .black, darkMode: .white)
let colorTextField = UIColor.createColor(lightMode: UIColor(red: 0.961, green: 0.953, blue: 0.933, alpha: 1), darkMode: .secondarySystemFill)
let colorDescriptionTextColor =  UIColor.createColor(lightMode: UIColor(red: 0.149, green: 0.196, blue: 0.22, alpha: 1) , darkMode: .secondarySystemFill)
let colorBlackView = UIColor.createColor(lightMode: .black, darkMode: .white)
 
extension UIColor {
    static func createColor(lightMode: UIColor, darkMode: UIColor) -> UIColor {
        guard #available(iOS 13.0, *) else
        { return lightMode }
        return UIColor { (traitCollection) -> UIColor in
            return traitCollection.userInterfaceStyle == .light ? lightMode : darkMode
        }
    }
}
