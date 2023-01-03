//
//  Checker.swift
//  Navigation
//
//  Created by Krime Loma on 30/9/22.
//

import UIKit


protocol LoginViewControllerDelegate {
    func check (login: String, password: String) -> Bool
}


final class Checker {
    static var shared = Checker()
#if DEBUG
    var login = "test"
    var password = ""
#else
    private var login = "cat"
    private var password = "12345"
#endif
    
    private init () {}
    func check(login: String, password: String) -> Bool {
        if login == self.login && password == self.password {
            return true
        }
        return false
    }
}

class LoginInspector : LoginViewControllerDelegate {
    func check(login: String, password: String) -> Bool {
        let checker = Checker.shared
        print ("Проверка синглтона")
        return checker.check(login: login, password: password)
    }
}

protocol LoginFactory {
    func makeLoginInspector ()  -> LoginInspector
}

struct MyLoginFactory: LoginFactory {
    func makeLoginInspector ()  -> LoginInspector {
        print ("Создан LoginInspector")
        return LoginInspector()
    }
}





