//
//  UserModel.swift
//  Navigation
//
//  Created by Kiryl Rakk on 6/3/23.
//

import UIKit

enum Sex: String {
    case male = "Мужской"
    case female = "Женский"
}

struct Account {
    var nickname: String
    var name: String
    var surname: String
    var avatar: String
    var status: String
    var sex: Sex
    var dateBirth: Date
    var hometown: String
    var friends: [Account]
    var posts : [AccountPosts]
}


struct AccountPosts {
    public var authorLabel: String
    public var descriptionLabel : String
    public  var image: UIImage?
    public  var likes: Int32
    public  var views: Int32
    public var date: Date
    public var isLiked: Bool = false
    public var comments: [Comments]
}

struct Comments {
    var account : Account
    var commentText: String
    var date: Date
    var likes: Int32
}


let maryAccount = Account(nickname: "Many_golusheva", name: "Маша", surname: "Голышева", avatar: "avatar", status: "Учитель", sex: .female, dateBirth: Date(), hometown: "Новокузнецк", friends: friends, posts: posts)






let post1 = AccountPosts(authorLabel: "Маша Голышева", descriptionLabel: "Конвертируйте видео в большинство популярных форматов. Меняйте формат видео всего за несколько секунд в режиме SuperSpeed без потери качества: ускорение до 81 раза по сравнению с обычной конвертацией!", image: UIImage(named:"app"), likes: 1, views: 1, date: Date(), comments: [comment1, comment2, comment6, comment5])
let post2 = AccountPosts(authorLabel: "Маша Голышева", descriptionLabel: "Я тебе рубль дал? В магазин послал? Тебе дали сдачу! Где деньги?", image: UIImage(named:"zina"),  likes: 2, views: 2, date: Date(), comments: [comment2,comment3])
let post3 = AccountPosts(authorLabel: "Маша Голышева", descriptionLabel: "今年已过半，大家事业感情怎么样？麦玲玲老师的新年运势一定要妥妥安排上，玲玲姐说属马的朋友2022年事业运和财运都会很好，属羊、属牛、属免的桃花运爆棚，属鸡的会遇贵人！快生成你的专属2022运势报告，虎年旺运秘快get起来！祝大家事事顺利，好运连连！点此测", image: UIImage(named:"china"),  likes: 3, views: 3, date: Date(), comments: [])
let post4 = AccountPosts(authorLabel: "Маша Голышева", descriptionLabel: "Базирующаяся в Лондоне компания TradingView отметила в октябре 2021 года 237%-ый посетителей с мая 2020-го, поскольку потребители обратили свое внимание на торговлю в условиях пандемического (пандемия коронавируса COVID-19) застоя. За указанный период TradingView сообщила о 400% скачке созданных аккаунтов", image: UIImage(named:"trade"), likes: 123, views: 355, date: Date(), comments: [comment4, comment5])
let post5 = AccountPosts(authorLabel: "Маша Голышева", descriptionLabel: "When you initialize your NSFetchedResultsController make sure to set the sectionNameKeyPath. This value should represent a field of your NSManagedObject that your controller is based on. I wanted my sections to be divided into the Artist names so I passed in name.", image: UIImage(named:"tradechina"), likes: 12, views: 14, date: Date(), comments: [comment5, comment6])


let account1 = Account(nickname: "alex_mor", name: "Александр", surname: "Мор", avatar: "friend1", status: "developer", sex: .male, dateBirth: Date(), hometown: "Москва", friends: [], posts: [])
let account2 = Account(nickname: "anatoly_kac", name: "Анатолий", surname: "Кац", avatar: "friend2", status: "Инженер", sex: .male, dateBirth: Date(), hometown: "Москва", friends: [], posts: [])
let account3 = Account(nickname: "alex_nav", name: "Алексей", surname: "Навальный", avatar: "friend3", status: "Политолог", sex: .male, dateBirth: Date(), hometown: "Москва", friends: [], posts: [])
let account4 = Account(nickname: "serg_jen", name: "Сергей", surname: "Кудряшов", avatar: "friend4", status: "Машинист", sex: .male, dateBirth: Date(), hometown: "Москва", friends: [], posts: [])
let account5 = Account(nickname: "elena_Batururu", name: "Елена", surname: "Батурина", avatar: "friend5", status: "Бухгалтер", sex: .female, dateBirth: Date(), hometown: "Москва", friends: [], posts: [])
let account6 = Account(nickname: "alisa_ya", name: "Алиса", surname: "Малышева", avatar: "friend6", status: "Дизайнер", sex: .female, dateBirth: Date(), hometown: "Москва", friends: [], posts: [])
let account7 = Account(nickname: "kir_zhuk", name: "Кирилл", surname: "Жук", avatar: "friend7", status: "Программист", sex: .female, dateBirth: Date(), hometown: "Москва", friends: [], posts: [])

let comment1 = Comments(account: account1, commentText: "Круто написано", date: Date(), likes: 2)
let comment2 = Comments(account: account2, commentText: "согласен", date: Date(), likes: 2)
let comment3 = Comments(account: account3, commentText: "Обалдеть", date: Date(), likes: 1)
let comment4 = Comments(account: account4, commentText: "Ужас!", date: Date(), likes: 0)
let comment5 = Comments(account: account5, commentText: "Ничего себе", date: Date(), likes: 0)
let comment6 = Comments(account: account6, commentText: "Конечно", date: Date(), likes: 2)
let comment7 = Comments(account: account7, commentText: "Спорно..", date: Date(), likes: 0)

var friends: [Account] = [account1, account2, account3, account4, account5, account6, account7]
var posts : [AccountPosts] = [post1, post2, post3, post4, post5]
var comments : [Comments] = []
