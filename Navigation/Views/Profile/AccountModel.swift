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

struct Profile {
    var account: Account
    var friends: [FriendProfile]
}

struct FriendProfile {
    var account: Account
    var friends: [Account]
}

class Account {
    var nickname: String
    var name: String
    var surname: String
    var avatar: UIImage?
    var status: String
    var sex: Sex
    var dateBirth: Date
    var hometown: String
    var posts : [AccountPosts]
    var comments: [Comments]
    
    init(nickname: String, name: String, surname: String, avatar: UIImage? = nil, status: String, sex: Sex, dateBirth: Date, hometown: String, posts: [AccountPosts], comments: [Comments]) {
        self.nickname = nickname
        self.name = name
        self.surname = surname
        self.avatar = avatar
        self.status = status
        self.sex = sex
        self.dateBirth = dateBirth
        self.hometown = hometown
        self.posts = posts
        self.comments = comments
    }
}


class AccountPosts {
    var authorLabel: String?
    var authorImage: UIImage?
    var statusLabel: String?
    var descriptionLabel : String
    var image: UIImage?
    var likes: Int32
    var views: Int32
    var date: Date
    var isLiked: Bool
    var id : String
    var comments: [Comments]
    init(authorLabel: String? = nil, authorImage: UIImage? = nil, statusLabel: String? = nil, descriptionLabel: String, image: UIImage? = nil, likes: Int32, views: Int32, date: Date, isLiked: Bool, id: String, comments: [Comments]) {
        self.authorLabel = authorLabel
        self.authorImage = authorImage
        self.statusLabel = statusLabel
        self.descriptionLabel = descriptionLabel
        self.image = image
        self.likes = likes
        self.views = views
        self.date = date
        self.isLiked = isLiked
        self.id = id
        self.comments = comments
    }
}

struct Comments {
    var idPost  : String
    var commentText: String
    var date: Date
    var likes: Int32
}


let profileMary = Profile(account: maryAccount, friends: [fr1, fr2, fr3, fr4, fr5, fr6, fr7])
let maryAccount = Account(nickname: "mary_golusheva", name: "Мария", surname: "Голышева", avatar: UIImage(named: "avatar"), status: "Учитель", sex: .female, dateBirth: Date(), hometown: "Новокузнецк", posts: posts, comments: [])

let fr1 = FriendProfile(account: account1, friends: [maryAccount, account2, account3, account4, account5, account6, account7, ])
let fr2 = FriendProfile(account: account2, friends: [account1, maryAccount, account3, account4, account5, account6, account7])
let fr3 = FriendProfile(account: account3, friends: [account1, account2, maryAccount, account4, account5, account6, account7])
let fr4 = FriendProfile(account: account4, friends: [account1, account2, account3, maryAccount, account5, account6, account7])
let fr5 = FriendProfile(account: account5, friends: [account1, account2, account3, account4, maryAccount, account6, account7])
let fr6 = FriendProfile(account: account6, friends: [account1, account2, account3, account4, account5, maryAccount, account7])
let fr7 = FriendProfile(account: account7, friends: [account1, account2, account3, account4, account5, account6, maryAccount])


var account1 = Account(nickname: "alex_mor", name: "Александр", surname: "Мор", avatar: UIImage(named: "friend1"), status: "developer", sex: .male, dateBirth: Date(), hometown: "Москва", posts: [post6,post7, post16], comments: [comment1, comment2, comment8, comment4])
var account2 = Account(nickname: "anatoly_kac", name: "Анатолий", surname: "Капчо", avatar: UIImage(named: "friend2"), status: "Инженер", sex: .male, dateBirth: Date(), hometown: "Москва",  posts: [post8, post9, post17], comments: [comment2, comment3, comment9])
var account3 = Account(nickname: "alex_nav", name: "Алексей", surname: "Грозный", avatar: UIImage(named: "friend3"), status: "Политолог", sex: .male, dateBirth: Date(), hometown: "Москва",  posts: [post10, post11], comments: [comment3, comment4, comment10])
var account4 = Account(nickname: "serg_jen", name: "Сергей", surname: "Кудряшов", avatar: UIImage(named: "friend4"), status: "Машинист", sex: .male, dateBirth: Date(), hometown: "Москва",  posts: [post12], comments: [comment5, comment6, comment11])
var account5 = Account(nickname: "elena_Batururu", name: "Елена", surname: "Батурина", avatar: UIImage(named: "friend5"), status: "Бухгалтер", sex: .female, dateBirth: Date(), hometown: "Москва", posts: [post13], comments: [comment7, comment8, comment12])
var account6 = Account(nickname: "alisa_ya", name: "Алиса", surname: "Малышева", avatar: UIImage(named: "friend6"), status: "Дизайнер", sex: .female, dateBirth: Date(), hometown: "Москва", posts: [post14], comments: [comment7, comment1, comment14])
var account7 = Account(nickname: "any_zhuk", name: "Анна", surname: "Жук", avatar: UIImage(named: "friend7"), status: "Программист", sex: .female, dateBirth: Date(), hometown: "Москва",  posts: [post15], comments: [comment2, comment3, comment4, comment13])

var comment1 = Comments(idPost: "post1", commentText: "Круто написано", date: Date(), likes: 2)
let comment2 = Comments(idPost: "post2", commentText: "согласен", date: Date(), likes: 2)
let comment3 = Comments(idPost: "post3", commentText: "Обалдеть", date: Date(), likes: 1)
let comment4 = Comments(idPost: "post4", commentText: "Ужас!", date: Date(), likes: 0)
let comment5 = Comments(idPost: "post5", commentText: "Ничего себе", date: Date(), likes: 0)
let comment6 = Comments(idPost: "post3", commentText: "Конечно", date: Date(), likes: 2)
let comment7 = Comments(idPost: "post4", commentText: "Спорно..", date: Date(), likes: 0)
let comment8 = Comments(idPost: "post1", commentText: "Конечно..", date: Date(), likes: 1)
let comment9 = Comments(idPost: "post1", commentText: "Конечно..", date: Date(), likes: 5)
let comment10 = Comments(idPost: "post2", commentText: "Конечно..", date: Date(), likes: 5)
let comment11 = Comments(idPost: "post3", commentText: "Конечно..", date: Date(), likes: 5)
let comment12 = Comments(idPost: "post4", commentText: "Конечно..", date: Date(), likes: 5)
let comment13 = Comments(idPost: "post5", commentText: "Конечно..", date: Date(), likes: 5)
let comment14 = Comments(idPost: "post5", commentText: "Конечно..", date: Date(), likes: 5)

var friends: [Account] = [account1, account2, account3, account4, account5, account6, account7]
var posts : [AccountPosts] = [post1, post2, post3, post4, post5]
var comments : [Comments] = [comment1, comment2, comment3, comment4, comment5, comment6, comment7]





let post1 = AccountPosts(descriptionLabel: "Конвертируйте видео в большинство популярных форматов. Меняйте формат видео всего за несколько секунд в режиме SuperSpeed без потери качества: ускорение до 81 раза по сравнению с обычной конвертацией!", image: UIImage(named:"app"), likes: 1, views: 1, date: Date(), isLiked: false, id: "post1", comments: [comment1, comment9, comment8])
let post2 = AccountPosts(descriptionLabel: "Я тебе рубль дал? В магазин послал? Тебе дали сдачу! Где деньги?", image: UIImage(named:"zina"),  likes: 2, views: 2, date: Date(), isLiked: false, id: "post2", comments: [comment10, comment2])
let post3 = AccountPosts(descriptionLabel: "今年已过半，大家事业感情怎么样？麦玲玲老师的新年运势一定要妥妥安排上，玲玲姐说属马的朋友2022年事业运和财运都会很好，属羊、属牛、属免的桃花运爆棚，属鸡的会遇贵人！快生成你的专属2022运势报告，虎年旺运秘快get起来！祝大家事事顺利，好运连连！点此测", image: UIImage(named:"china"),  likes: 3, views: 3, date: Date(), isLiked: false, id: "post3", comments: [comment3, comment11, comment3])
let post4 = AccountPosts(descriptionLabel: "Базирующаяся в Лондоне компания TradingView отметила в октябре 2021 года 237%-ый посетителей с мая 2020-го, поскольку потребители обратили свое внимание на торговлю в условиях пандемического (пандемия коронавируса COVID-19) застоя. За указанный период TradingView сообщила о 400% скачке созданных аккаунтов", image: UIImage(named:"trade"), likes: 123, views: 355, date: Date(),isLiked: false, id: "post4", comments: [comment4, comment12, comment7])
let post5 = AccountPosts(descriptionLabel: "When you initialize your NSFetchedResultsController make sure to set the sectionNameKeyPath. This value should represent a field of your NSManagedObject that your controller is based on. I wanted my sections to be divided into the Artist names so I passed in name.", image: UIImage(named:"tradechina"), likes: 11, views: 14, date: Date(), isLiked: false, id: "post5", comments: [comment5, comment13])

let post6 = AccountPosts(descriptionLabel: "Ученые из Медицинского центра Cedars-Sinai в Лос-Анджелесе изучили глаза и ткани мозга 86 умерших человек с диагностированными когнитивными нарушениями. Во время исследования удалось найти особенности, которые позволяют диагностировать болезнь Альцгеймера на ранних стадиях — до появления очевидных симптомов, пишет Fox News.", image: UIImage(named:"8"), likes: 12, views: 14, date: Date(), isLiked: false, id: "post6", comments: [comment5, comment13])
let post7 = AccountPosts(descriptionLabel: "В петербургском пространстве «Сообщество» открылся киноклуб, где независимые режиссеры представляют свои новые фильмы и обсуждают их с молодыми кинокритиками самиздата «К!».", image: UIImage(named:"7"), likes: 12, views: 14, date: Date(), isLiked: false, id: "post7", comments: [comment5, comment13])
let post8 = AccountPosts(descriptionLabel: "Экземпляр будет продан с молотка на аукционе Sotheby’s в Нью-Йорке в мае. За него нужно будет заплатить от 30 до 50 миллионов долларов. Так он может стать самым дорогим историческим документом, когда-либо проданным на аукционе.", image: UIImage(named:"6"), likes: 116, views: 14, date: Date(), isLiked: false, id: "post8", comments: [ comment13])
let post9 = AccountPosts(descriptionLabel: "Мужчинам труднее справиться со смертью любимого человека, чем женщинам. Так же выше вероятность, что они сами умрут в течение года после потери. Это может быть связано с гендерными ролями в семье и тем, что женщины более психологически устойчивы.", image: UIImage(named:"5"), likes: 19, views: 14, date: Date(), isLiked: false, id: "post9", comments: [comment5, comment13])
let post10 = AccountPosts(descriptionLabel: "В коллекции Музея янтаря в Калининграде нашли камень, в котором сохранилось ранее неизвестное доисторическое насекомое. Это предок современных ос, живший 40-45 миллионов лет назад. Вероятно, насекомое оказалось в смоле, потому что село на дерево, где обитали его жертвы.", image: UIImage(named:"3"), likes: 13, views: 14, date: Date(), isLiked: false, id: "post10", comments: [comment13])
let post11 = AccountPosts(descriptionLabel: "Что такое характер и хара́ктерность в искусстве? Действительно ли характерный — значит смешной? Характерностью часто называют актерское, театральное свойство. Характерный артист — тот, кто играет яркие, запоминающиеся роли. Обычно не главные. Откуда взялось это представление? Есть ли характер в изобразительном искусстве, и если да, то как он выражается? Почему считается, что характерный — значит некрасивый, как этот стереотип живет в современной культуре и как связаны герои живописи XVII века с Джеком Воробьем? Рассказывает искусствовед и автор телеграм-канала «бесполезный гуманитарий» Анастасия Семенович.", image: UIImage(named:"2"), likes: 14, views: 14, date: Date(), isLiked: false,  id: "post11", comments: [comment5, comment13])
let post12 = AccountPosts(descriptionLabel: "Обычно мы делим покупки на рациональные и иррациональные. С первыми всё понятно — они закрывают базовые потребности. Это, например, еда и одежда. А что насчет подписки на онлайн-кинотеатр? Это не жизненно важная покупка, но для трудоголика, который вечером без сил валится на диван, просмотр сериала — простой и привычный способ расслабиться", image: UIImage(named:"1"), likes: 15, views: 14, date: Date(), isLiked: false, id: "post12", comments: [ comment13])

let post13 = AccountPosts(descriptionLabel: "When the sun is shining and the temperature is rising, there's nothing quite like a cold drink to quench your thirst and cool you down. Whether it's an ice-cold lemonade, a refreshing iced tea, or a frosty glass of your favorite soda, there's something about a cold beverage that just hits the spot on a hot summer day.", image: UIImage(named:"15"), likes: 15, views: 14, date: Date(), isLiked: false, id: "post13", comments: [comment5, comment13])
let post14 = AccountPosts(descriptionLabel: "Nothing beats the heat like a cold drink on a sunny day ☀️🍹 What's your go-to thirst quencher? Share with us in the comments below! #coldbeverages #summertime #refreshing #thirstquencher", image: UIImage(named:"15"), likes: 15, views: 14, date: Date(), isLiked: false, id: "post14", comments: [comment5, comment13])
let post15 = AccountPosts(descriptionLabel: "So, we want to hear from you! What's your go-to thirst quencher when the weather heats up? Do you prefer something fruity, something bubbly, or something with a little kick of caffeine? Are you a fan of classic summer drinks like iced tea and lemonade, or do you like to mix things up with more unconventional options like iced coffee or smoothies?", image: UIImage(named:"15"), likes: 15, views: 14, date: Date(), isLiked: false, id: "post15", comments: [comment13])
let post16 = AccountPosts(descriptionLabel: "Share your favorite cold drink with us in the comments below. We can't wait to hear what you're sipping on this summer! ☀️🍹 #coldbeverages #summertime #refreshing #thirstquencher", image: UIImage(named:"16"), likes: 15, views: 14, date: Date(), isLiked: false, id: "post16", comments: [comment5, comment13])
let post17 = AccountPosts(descriptionLabel: "Share your favorite cold drink with us in the comments below. And don't forget to tell us why you love it so much! Is it the flavor that keeps you coming back for more? The way it makes you feel on a hot summer day? Or the memories it evokes of summers past? We can't wait to hear what you're sipping on this summer! ☀️🍹  #coldbeverages #summertime #refreshing #thirstquencher", image: UIImage(named:"17"), likes: 15, views: 14, date: Date(), isLiked: false, id: "post17", comments: [ comment13])


