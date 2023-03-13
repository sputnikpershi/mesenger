//
//  AccountHelper.swift
//  Navigation
//
//  Created by Kiryl Rakk on 26/1/23.
//

import Foundation
import RealmSwift


class LoginHelper {
    
    
    var login : String?
    var delegate: CheckerServiceProtocol?
    
    func signIn (_ email: String, password: String) -> String?  {
        self.login = (delegate?.signIn(email, password: password))
        if login == "" || login == " " {
            return nil
        } else {
            return login
        }
    }
    
    func signUp (_ email: String, password: String)  {
        login = (delegate?.signUp(email, password: password))
    }
}
