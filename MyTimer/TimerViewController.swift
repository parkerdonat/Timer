//
//  TimerViewController.swift
//  MyTimer
//
//  Created by Daniel Dickson on 2/9/16.
//  Copyright © 2016 Daniel Dickson. All rights reserved.
//

import UIKit

class TimerViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var hoursPicker: UIPickerView!
    @IBOutlet weak var minutesPicker: UIPickerView!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var pickerStackView: UIStackView!
    @IBOutlet weak var progressView: UIProgressView!
    
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "updateTimerBasedViews", name: Timer.notificationSecondTick, object: timer)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "timerComplete", name: Timer.notificationComplete, object: timer)
        
        minutesPicker.selectRow(1, inComponent: 0, animated: false)
        
        view.layoutIfNeeded()
        
        pauseButton.layer.cornerRadius = pauseButton.bounds.height / 5
        pauseButton.layer.masksToBounds = true
        pauseButton.layer.borderWidth = 2.0
        pauseButton.layer.borderColor = UIColor.blueColorTimer().CGColor
        
        startButton.layer.cornerRadius = startButton.bounds.height / 5
        startButton.layer.masksToBounds = true
        startButton.layer.borderWidth = 2.0
        startButton.layer.borderColor = UIColor.lightBlueColorTimer().CGColor
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Actions
    
    @IBAction func pauseButtonTapped(sender: AnyObject) {
    }
    
    @IBAction func startButtonTapped(sender: AnyObject) {
        toggleTimer()
    }
    
    // MARK: - UIPickerView Protocols
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == hoursPicker {
            return 24
        } else if pickerView == minutesPicker {
            return 60
        } else {
            return 0
        }
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(row)"
    }
    
    // MARK: - View Updating Methods
    
    func toggleTimer() {
        if timer.isOn {
            timer.stopTimer()
            switchToPickerView()
        } else {
            switchToTimerView()
            
            let hours = hoursPicker.selectedRowInComponent(0)
            let minutes = minutesPicker.selectedRowInComponent(0) + (hours * 60)
            let totalSecondsSetOnTimer = NSTimeInterval(minutes * 60)
            
            timer.setTimer(totalSecondsSetOnTimer, totalSeconds: totalSecondsSetOnTimer)
            updateTimerBasedViews()
            timer.startTimer()
        }
    }
    
    func updateTimerLabel() {
        
        timerLabel.text = timer.string
    }
    
    func updateProgressView() {
        
        let secondsElapsed = timer.totalSeconds - timer.seconds
        
        let progress = Float(secondsElapsed) / Float(timer.totalSeconds)
        
        progressView.setProgress(progress, animated: true)
    }
    
    func updateTimerBasedViews() {
        updateTimerLabel()
        updateProgressView()
    }
    
    func timerComplete() {
        let timerCompleteAlert = UIAlertController(title: "Timer Complete!", message: nil, preferredStyle: .Alert)
        timerCompleteAlert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
            self.switchToPickerView()
        }))
        presentViewController(timerCompleteAlert, animated: true, completion: nil)
    }
    
    func switchToTimerView() {
        timerLabel.hidden = false
        progressView.setProgress(0.0, animated: false)
        progressView.hidden = false
        pickerStackView.hidden = true
        startButton.setTitle("Cancel", forState: .Normal)
        
        startButton.setTitleColor(UIColor.blueColorTimer(), forState: .Normal)
        startButton.layer.borderColor = UIColor.blueColorTimer().CGColor
        pauseButton.setTitleColor(UIColor.lightBlueColorTimer(), forState: .Normal)
        pauseButton.layer.borderColor = UIColor.lightBlueColorTimer().CGColor
    }
    
    func switchToPickerView() {
        pickerStackView.hidden = false
        timerLabel.hidden = true
        progressView.hidden = true
        startButton.setTitle("Start", forState: .Normal)
        
        startButton.setTitleColor(UIColor.lightBlueColorTimer(), forState: .Normal)
        startButton.layer.borderColor = UIColor.lightBlueColorTimer().CGColor
        pauseButton.setTitleColor(UIColor.blueColorTimer(), forState: .Normal)
        pauseButton.layer.borderColor = UIColor.blueColorTimer().CGColor
    }
}
