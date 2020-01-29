//
//  AppDelegate.swift
//  Gank.lu
//  
//  Kobe Retire
//  Created by FIND.ME on 16/1/2.
//  Copyright © 2016年 smartalker. All rights reserved.
//

import UIKit

let navColor = UIColor(red: 44/255.0, green: 62/255.0, blue: 80/255.0, alpha: 1.0)

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let navBar = UINavigationBar.appearance()
        navBar.barTintColor = navColor
        navBar.tintColor = UIColor.white
        navBar.barStyle = .blackTranslucent
    navBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        
        return true
    }

}

