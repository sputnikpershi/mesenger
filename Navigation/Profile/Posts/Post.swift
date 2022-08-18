//
//  File.swift
//  Navigation
//
//  Created by Krime Loma    on 7/30/22.
//

import UIKit

struct Post {
    var authorLabel: String
    var descriptionLabel : String
    var image: String
    var likes: Int
    var views: Int
}



var postArray = [Post(authorLabel: "zina.nizina",
                                        descriptionLabel: "Конвертируйте видео в большинство популярных форматов. Меняйте формат видео всего за несколько секунд в режиме SuperSpeed без потери качества: ускорение до 81 раза по сравнению с обычной конвертацией!",
                      image: "app", likes: 12, views: 125),
                 Post(authorLabel: "xiaomi.mozga",
                                       descriptionLabel: "Я тебе рубль дал? В магазин послал? Тебе дали сдачу! Где деньги?",
                                       image: "zina", likes: 5774, views: 6790),
                 Post(authorLabel: "china.mama",
                                       descriptionLabel: "今年已过半，大家事业感情怎么样？麦玲玲老师的新年运势一定要妥妥安排上，玲玲姐说属马的朋友2022年事业运和财运都会很好，属羊、属牛、属免的桃花运爆棚，属鸡的会遇贵人！快生成你的专属2022运势报告，虎年旺运秘快get起来！祝大家事事顺利，好运连连！点此测",
                                       image: "china", likes: 1032, views: 4039),
                 Post(authorLabel: "tradindView.official",
                                       descriptionLabel: "Базирующаяся в Лондоне компания TradingView отметила в октябре 2021 года 237%-ый посетителей с мая 2020-го, поскольку потребители обратили свое внимание на торговлю в условиях пандемического (пандемия коронавируса COVID-19) застоя. За указанный период TradingView сообщила о 400% скачке созданных аккаунтов",
                                       image: "trade", likes: 520, views: 6990),
]
