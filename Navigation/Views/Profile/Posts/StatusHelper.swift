//
//  StatusHelper.swift
//  Navigation
//
//  Created by Kiryl Rakk on 25/1/23.
//

import Foundation
import RealmSwift
import Realm

//protocol StatusDelegate {
//    func sentStatus(text: String) -> String?
//}

class StatusHelper {
    func getStatus(text: String) -> String? {
        if text != "" && text != " " {
            return text
        } else {
            return nil
        }
        
    }
}

