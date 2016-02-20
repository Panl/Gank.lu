//
//  BaseViewController.swift
//  Gank.lu
//
//  Created by FIND.ME on 16/2/18.
//  Copyright © 2016年 smartalker. All rights reserved.
//

import UIKit
import RainbowNavigation

class BaseViewController: UIViewController{
    let navColor = UIColor(red: 44/255.0, green: 62/255.0, blue: 80/255.0, alpha: 1.0)

    override func viewDidLoad() {
        initNavigationBar()
    }
    
    func initNavigationBar(){
        navigationController?.navigationBar.barTintColor = navColor
        navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        navigationController?.navigationBar.barStyle = UIBarStyle.BlackTranslucent
        let navigationTitleAttribute : NSDictionary = NSDictionary(object: UIColor.whiteColor(),forKey: NSForegroundColorAttributeName)
        navigationController?.navigationBar.titleTextAttributes =  navigationTitleAttribute as? [String : AnyObject]
        
    }
    
}
