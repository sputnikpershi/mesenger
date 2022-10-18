//
//  User.swift
//  Navigation
//
//  Created by Krime Loma on 26/9/22.
//

import UIKit
protocol UserServiceProtocol {
    func getUser(login: String) -> User?
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


final class TestUserService: UserServiceProtocol {
    let user = User(login: "test", fullName: "Тестанутый Тестамес", image: UIImage(named: "cat")!, status: "Я тебя тестирую на наличие багов")

    func getUser(login: String) -> User? {
        login == user.login ? user : nil
    }
}

final class CurrentUserService: UserServiceProtocol {

    let user = User(login: "cat", fullName: "Товарищъ Мяу", image: UIImage(named: "cat")!, status: "Коженный, ты где?")

    func getUser(login: String) -> User? {
        login == user.login ? user : nil
    }
}

var users = [User(login: "cat", fullName: "Товарищъ Мяу", image: UIImage(named: "cat")!, status: "Коженный, ты где?"), User(login: "dog", fullName: "Товарищъ Гау", image: UIImage(named: "dog")!, status: "В поисках новых друзей")]
var testUsers = [User(login: "test", fullName: "Тестанутый Тестамес", image: UIImage(named: "cat")!, status: "Я тебя тестирую на наличие багов")]
var usersData = ["cat": "12345", "dog": "12345"]
var testUsersData = ["test": "test"]


enum LogingError: Error {
    case emptyField
    case wrongData
    case errorNetwork
}
