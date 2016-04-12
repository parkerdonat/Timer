//
//  Alarm.swift
//  Timer
//
//  Created by Parker Donat on 4/12/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import Foundation
import UIKit

class Alarm {
    
    static let categoryAlarm = "categoryAlarm"
    static let notificationComplete = "notificationComplete"
    
    private(set) var alarmDate: NSDate?
    var isArmed: Bool {
        get {
            if alarmDate != nil {
                return true
            } else {
                return false
            }
        }
    }
    
    private var localNotification: UILocalNotification?
    
    func arm(fireDate: NSDate) {
        alarmDate = fireDate
        let alarmNotification = UILocalNotification()
        alarmNotification.fireDate = alarmDate
        alarmNotification.timeZone = NSTimeZone.localTimeZone()
        alarmNotification.soundName = "sms-received3.caf"
        alarmNotification.alertBody = "Alarm Complete!"
        alarmNotification.category = Alarm.categoryAlarm
        
        UIApplication.sharedApplication().scheduleLocalNotification(alarmNotification)
    }
    
    func cancel() {
        if isArmed {
            alarmDate = nil
            if let localNotification = localNotification {
                UIApplication.sharedApplication().cancelLocalNotification(localNotification)
                UIApplication.sharedApplication().cancelAllLocalNotifications()
            }
        }
    }
    
    static func alarmComplete() {
        NSNotificationCenter.defaultCenter().postNotificationName(Alarm.notificationComplete, object: nil)
    }
}