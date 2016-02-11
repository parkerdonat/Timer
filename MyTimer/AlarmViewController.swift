//
//  AlarmViewController.swift
//  MyTimer
//
//  Created by Daniel Dickson on 2/9/16.
//  Copyright © 2016 Daniel Dickson. All rights reserved.
//

import UIKit

class AlarmViewController: UIViewController {

    @IBOutlet weak var datePickerView: UIDatePicker!
    @IBOutlet weak var notificationLabel: UILabel!
    @IBOutlet weak var timeConfirmationLabel: UILabel!
    @IBOutlet weak var alarmButton: UIButton!
    
    let alarm = Alarm()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        datePickerView.minimumDate = NSDate()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "switchToNotSetView", name: Alarm.notificationComplete, object: nil)
        
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func alarmButtonTapped(sender: AnyObject) {
        
        if alarm.isArmed {
            alarm.cancel()
            switchToNotSetView()
        } else {
            alarm.arm(datePickerView.date)
            switchToSetView()
        }
        
    }
    
    func switchToNotSetView() {
        alarm.cancel()
        datePickerView.minimumDate = NSDate()
        datePickerView.date = NSDate()
        datePickerView.userInteractionEnabled = true
        notificationLabel.text = "Your alarm has not been set"
        timeConfirmationLabel.text = ""
        alarmButton.setTitle("Set Alarm", forState: .Normal)
    }
    
    func switchToSetView() {
        datePickerView.userInteractionEnabled = false
        notificationLabel.text = "Your alarm is set for:"
        alarmButton.setTitle("Cancel Alarm", forState: .Normal)
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.timeStyle = .ShortStyle
        dateFormatter.dateStyle = .LongStyle
        
        if let date = alarm.alarmDate {
            timeConfirmationLabel.text = dateFormatter.stringFromDate(date)
            datePickerView.date = date
        } else {
            timeConfirmationLabel.text = ""
        }
    }
}
