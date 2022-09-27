//
//  User.swift
//  Navigation
//
//  Created by Krime Loma on 26/9/22.
//

import UIKit
protocol UserServiceProtocol {
    func searchLogin (login: String) -> User?
    func isRightPassword (with login: String, password: String) -> Bool
}

class User {
    var login : String
    var fullName: String
    var image: UIImage
    var status: String
    
    init(login: String, fullName: String, image: UIImage, status: String) {
        self.login = login
        self.fullName = fullName
        self.image = image
        self.status = status
    }
}




class TestUserService: UserServiceProtocol {
    
    var users: [User] = []
    
    // Поиск и передача объекта User по ввведенному логину
    func searchLogin(login: String) -> User? {
        for user in users  {
            if user.login == login {
                print("Найдены данные для логина \(user.login)")
                return user
            }
        }
        return nil
    }
    
    // Проверка на существование пароля для определенного логина в usersData: [String : String]
    func isRightPassword (with login: String, password: String) -> Bool {
        for key in testUsersData.keys  {
            if key == login && testUsersData[key] == password {
                print("True")
                return true
            }
        }
        return false
    }
}

class CurrentUserService: UserServiceProtocol {
    
    var users: [User] = []
    
    // Поиск и передача объекта User по ввведенному логину
    func searchLogin(login: String) -> User? {
        for user in users  {
            if user.login == login {
                print("Найдены данные для логина \(user.login)")
                return user
            }
        }
        return nil
    }
    
    // Проверка на существование пароля для определенного логина в usersData: [String : String]
    func isRightPassword (with login: String, password: String) -> Bool {
        for key in usersData.keys  {
            if key == login && usersData[key] == password {
                print("True")
                return true
            }
        }
        return false
    }
}




var users = [User(login: "cat", fullName: "Товарищъ Мяу", image: UIImage(named: "cat")!, status: "Коженный, ты где?"), User(login: "dog", fullName: "Товарищъ Гау", image: UIImage(named: "dog")!, status: "В поисках новых друзей")]
var testUsers = [User(login: "test", fullName: "Тестанутый Тестамес", image: UIImage(named: "bug")!, status: "Я тебя тестирую на начие багов")]
var usersData = ["cat": "12345", "dog": "12345"]
var testUsersData = ["test": "test"]
