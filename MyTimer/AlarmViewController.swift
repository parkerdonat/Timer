//
//  AlarmViewController.swift
//  MyTimer
//
//  Created by Daniel Dickson on 2/9/16.
//  Copyright © 2016 Daniel Dickson. All rights reserved.
//

import UIKit

class AlarmViewController: UIViewController {

    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var alarmButton: UIButton!
    
    let alarm = Alarm()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        datePicker.minimumDate = NSDate()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "switchToAlarmNotSetView", name: Alarm.notificationComplete, object: nil)
        
        guard let scheduledNotifications = UIApplication.sharedApplication().scheduledLocalNotifications else { return }
        alarm.cancel()
        
        for notification in scheduledNotifications {
            if notification.category == Alarm.categoryAlarm {
                UIApplication.sharedApplication().cancelLocalNotification(notification)
                
                guard let fireDate = notification.fireDate else { return }
                alarm.arm(fireDate)
                switchToSetView()
            }
        }
    }

    @IBAction func alarmButtonTapped(sender: AnyObject) {
        if alarm.isArmed {
            alarm.cancel()
            switchToNotSetView()
        } else {
            armAlarm()
        }
        
    }
    
    func armAlarm() {
        alarm.arm(datePicker.date)
        switchToSetView()
    }
    
    func switchToNotSetView() {
        alarm.cancel()
        datePicker.minimumDate = NSDate()
        datePicker.date = NSDate()
        messageLabel.text = "Your alearm has not been set."
        dateLabel.text = ""
        alarmButton.setTitle("Set Alarm", forState: .Normal)
        datePicker.userInteractionEnabled = true
    }
    
    func switchToSetView() {
        let dateFormatter = NSDateFormatter()
        dateFormatter.timeStyle = .ShortStyle
        dateFormatter.dateStyle = .LongStyle
        
        messageLabel.text = "Your alarm is set!"
        
        if let date = alarm.alarmDate {
            dateLabel.text = dateFormatter.stringFromDate(date)
            datePicker.date = date
        } else {
            dateLabel.text = ""
        }
        
        alarmButton.setTitle("Cancel Alarm", forState: .Normal)
        datePicker.userInteractionEnabled = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
