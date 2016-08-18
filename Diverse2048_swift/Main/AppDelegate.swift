//
//  AppDelegate.swift
//  Diverse2048_swift
//
//  Created by Tech on 16/8/12.
//  Copyright © 2016年 ctc. All rights reserved.
//

import UIKit
//import LeanCloud

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window?.backgroundColor = UIColor.whiteColor()
        window?.rootViewController = HomeVc()
        window?.makeKeyAndVisible()
        
        
        
        
        
        soundManager.initSound()

        return true
    }

}

