//
//  Coordinator.swift
//  Navigation
//
//  Created by Kiryl Rakk on 9/10/22.
//

import UIKit


protocol Coordinator {
    func start()
}

protocol Coordinating {
    var coordinator: Coordinator? {get set}
}
