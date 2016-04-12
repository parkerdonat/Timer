//
//  AppearanceController.swift
//  Timer
//
//  Created by Parker Donat on 4/11/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import Foundation
import UIKit

class AppearanceController {
    
    static func initializeAppearance() {
        
        //Set colors for entire app.
        UINavigationBar.appearance().barTintColor = UIColor.darkGreyColorTimer()
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor()]
//        if let font = UIFont(name: "HelveticaNeue-UltraLight", size: 20) {
//            UINavigationBar.appearance().titleTextAttributes = [NSFontAttributeName: font]
//        }
        UITabBar.appearance().barTintColor = UIColor.darkGreyColorTimer()
        UITabBar.appearance().tintColor = UIColor.lightBlueColorTimer()
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName : UIColor.lightBlueColorTimer()], forState: .Selected)
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName : UIColor.lightGrayColor()], forState: .Normal)
        
    }
}