//
//  File.swift
//  Navigation
//
//  Created by Krime Loma    on 7/30/22.
//

import UIKit

public struct Post {
    public var authorLabel: String
    public var descriptionLabel : String
    public  var image: String
    public  var likes: Int32
    public  var views: Int32
    public var isLiked: Bool = false
}


public var postArray = [
                        Post(authorLabel: "zina.nizina",
                             descriptionLabel: "Конвертируйте видео в большинство популярных форматов. Меняйте формат видео всего за несколько секунд в режиме SuperSpeed без потери качества: ускорение до 81 раза по сравнению с обычной конвертацией!",
                             image: "app", likes: 1, views: 1),
                        Post(authorLabel: "xiaomi.mozga",
                             descriptionLabel: "Я тебе рубль дал? В магазин послал? Тебе дали сдачу! Где деньги?",
                             image: "zina", likes: 2, views: 2),
                        Post(authorLabel: "china.mama",
                             descriptionLabel: "今年已过半，大家事业感情怎么样？麦玲玲老师的新年运势一定要妥妥安排上，玲玲姐说属马的朋友2022年事业运和财运都会很好，属羊、属牛、属免的桃花运爆棚，属鸡的会遇贵人！快生成你的专属2022运势报告，虎年旺运秘快get起来！祝大家事事顺利，好运连连！点此测",
                             image: "china", likes: 3, views: 3),
                        Post(authorLabel: "tradindView.official",
                             descriptionLabel: "Базирующаяся в Лондоне компания TradingView отметила в октябре 2021 года 237%-ый посетителей с мая 2020-го, поскольку потребители обратили свое внимание на торговлю в условиях пандемического (пандемия коронавируса COVID-19) застоя. За указанный период TradingView сообщила о 400% скачке созданных аккаунтов",
                             image: "trade", likes: 4, views: 4),
                        Post(authorLabel: "china.mama",
                             descriptionLabel: "When you initialize your NSFetchedResultsController make sure to set the sectionNameKeyPath. This value should represent a field of your NSManagedObject that your controller is based on. I wanted my sections to be divided into the Artist names so I passed in name.",
                             image: "tradechina", likes: 5220, views: 690),
]
