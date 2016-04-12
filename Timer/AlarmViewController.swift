//
//  AlarmViewController.swift
//  Timer
//
//  Created by Parker Donat on 4/11/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit

class AlarmViewController: UIViewController {
    
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var alarmButton: UIButton!
    
//    @IBOutlet weak var datePicker: UIDatePicker!
//    @IBOutlet weak var messageLabel: UILabel!
//    @IBOutlet weak var dateLabel: UILabel!
//    @IBOutlet weak var alarmButton: UIButton!
    
    let alarm = Alarm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        datePicker.minimumDate = NSDate()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(switchToAlarmNotSetView), name: Alarm.notificationComplete, object: nil)
        
        guard let scheduledNotifications = UIApplication.sharedApplication().scheduledLocalNotifications else { return }
        alarm.cancel()
        
        for notification in scheduledNotifications {
            if notification.category == Alarm.categoryAlarm {
                UIApplication.sharedApplication().cancelLocalNotification(notification)
                
                guard let fireDate = notification.fireDate else { return }
                alarm.arm(fireDate)
                switchToAlarmSetView()
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func alarmButtonPressed(sender: AnyObject) {
        if alarm.isArmed {
            alarm.cancel()
            switchToAlarmSetView()
        } else {
            alarm.arm(datePicker.date)
            switchToAlarmSetView()
        }
        
    }
    
    func armAlarm() {
        alarm.arm(datePicker.date)
        switchToAlarmSetView()
    }
    
    func switchToAlarmSetView() {
        let dateFormatter = NSDateFormatter()
        dateFormatter.timeStyle = .ShortStyle
        dateFormatter.dateStyle = .LongStyle
        
        messageLabel.text = "Your alarm is set for..."
        
        if let date = alarm.alarmDate {
            dateLabel.text = dateFormatter.stringFromDate(date)
            datePicker.date = date
        } else {
            dateLabel.text = ""
        }
        
        alarmButton.setTitle("Cancel Alarm", forState: .Normal)
        datePicker.userInteractionEnabled = false
    }
    
    func switchToAlarmNotSetView() {
        alarm.cancel()
        messageLabel.text = "Your alarm is not set."
        dateLabel.text = ""
        alarmButton.setTitle("Set Alarm", forState: .Normal)
        datePicker.minimumDate = NSDate()
        datePicker.date = NSDate()
        datePicker.userInteractionEnabled = true
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
