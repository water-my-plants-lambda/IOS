//
//  LocalNotificationHelper.swift
//  Water My Plants
//
//  Created by Lisa Sampson on 5/30/19.
//  Copyright © 2019 Mitchell Budge. All rights reserved.
//

import Foundation
import UserNotifications

class LocalNotificationHelper: NSObject, UNUserNotificationCenterDelegate {
    
    // MARK: - Properties
    var plantController: PlantController?
    
    // MARK: - LocalNotificationController Delagate Methods
    
    func getAuthorizationStatus(completion: @escaping (UNAuthorizationStatus) -> Void) {
        UNUserNotificationCenter.current().getNotificationSettings { (settings) in
            DispatchQueue.main.async {
                completion(settings.authorizationStatus)
            }
        }
    }
    
    func requestAuthorizationStatus(completion: @escaping (Bool) -> Void) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { (success, error) in
            if let error = error {
                NSLog("Error requesting authorization status for local notifications: \(error)")
            }
            DispatchQueue.main.async {
                completion(success)
            }
        }
    }
    
    func scheduleDailyReminderNotification(name: String, times: Date, calendar: Calendar) {
        let df = DateFormatter()
        df.dateStyle = .none
        df.timeStyle = .short
        let time = df.string(from: times)
        let dateComponents = calendar.dateComponents([.hour, .minute], from: times)
        
        let content = UNMutableNotificationContent()
        content.title = "It's time to water \(name)."
        content.body = "It's \(time)! \(name) is getting thirsty."
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let request = UNNotificationRequest(identifier: "PlantIdentifier", content: content, trigger: trigger)
        let center = UNUserNotificationCenter.current()
        center.delegate = self
        
        center.add(request) { (error) in
            if let error = error {
                print("There was an error scheduling a notification: \(error)")
                return
            }
        }
    }
}
