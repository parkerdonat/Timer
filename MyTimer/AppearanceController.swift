//
//  AppearanceController.swift
//  MyTimer
//
//  Created by Daniel Dickson on 2/9/16.
//  Copyright © 2016 Daniel Dickson. All rights reserved.
//

import Foundation
import UIKit

class AppearanceController {
    
    static func initializeAppearance() {
        
        // Set colors for the whole app
        UINavigationBar.appearance().barTintColor = UIColor.blueColorTimer()
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor()]
        UITabBar.appearance().barTintColor = UIColor.blueColorTimer()
        UITabBar.appearance().tintColor = UIColor.lightBlueColorTimer()
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName : UIColor.lightBlueColorTimer()], forState: .Normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName : UIColor.whiteColor()], forState: .Selected)
    }
}