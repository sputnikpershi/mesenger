//
//  NotificationManager.swift
//  Navigation
//
//  Created by Kiryl Rakk on 31/1/23.
//

import Foundation
import UserNotifications
import UIKit


class LocalNotificationsService: NSObject, UNUserNotificationCenterDelegate {
    let center = UNUserNotificationCenter.current()
    let categoryIdentifier = "updates"
    let content = UNMutableNotificationContent()
    var dateComponet = DateComponents()
    weak var delegate : UNUserNotificationCenterDelegate?
    
    func registeForLatestUpdatesIfPossible() {
        registerUpdatesCategory()
        center.requestAuthorization(options: [.sound, .badge, .alert]) { success, error in
            if let error {
                print(String(describing: error.localizedDescription))
            }
            if success {
                self.content.sound = .defaultCritical
                self.content.title = "Do homework"
                self.content.body = "We have some issues to do to"
                self.content.categoryIdentifier = self.categoryIdentifier
                self.dateComponet.hour = 19
                //                let trigger = UNCalendarNotificationTrigger(dateMatching: self.dateComponet, repeats: true)
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 7, repeats: false)
                let request = UNNotificationRequest(identifier: "identifier", content: self.content, trigger: trigger)
                self.center.add(request)
            } else {
                print("Access unavailable")
            }
        }
        
        func registerUpdatesCategory() {
            center.delegate = self
            let showAction = UNNotificationAction(identifier: "show", title: "show", options: .destructive)
            let dissmissAction = UNNotificationAction(identifier: "dissmiss", title: "dissmiss", options: .destructive)
            let category = UNNotificationCategory(identifier: categoryIdentifier, actions: [showAction,dissmissAction], intentIdentifiers: [])
            let categories : Set<UNNotificationCategory> = [category]
            center.setNotificationCategories(categories)
        }
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        switch response.actionIdentifier {
        case UNNotificationDefaultActionIdentifier:
            print("переход на экран приложения")
        case "show":
            print("pushed SHOW button")
        case "dissmiss":
            print("pushed DISSMISS button")
        default: print("some error in the switch")
        }
        completionHandler()
    }
}

