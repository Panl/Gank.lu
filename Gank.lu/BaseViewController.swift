//
//  BaseViewController.swift
//  Gank.lu
//
//  Created by FIND.ME on 16/2/18.
//  Copyright © 2016年 smartalker. All rights reserved.
//

import UIKit
import RainbowNavigation

class BaseViewController: UIViewController,RainbowColorSource{
    lazy var rainbowNavigation = RainbowNavigation()
    let navColor = UIColor(red: 44/255.0, green: 62/255.0, blue: 80/255.0, alpha: 1.0)

    override func viewDidLoad() {
        initNavigationBar()
    }
    
    func initNavigationBar(){
        navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        navigationController?.navigationBar.df_setBackgroundColor(navColor)
        navigationController?.navigationBar.df_setStatusBarMaskColor(UIColor(white: 0, alpha: 0.1))
        let navigationTitleAttribute : NSDictionary = NSDictionary(object: UIColor.whiteColor(),forKey: NSForegroundColorAttributeName)
        navigationController?.navigationBar.titleTextAttributes =  navigationTitleAttribute as? [String : AnyObject]
        if let navigationController = navigationController {
            rainbowNavigation.wireTo(navigationController: navigationController)
        }
    }
    
    func navigationBarInColor() -> UIColor {
        return navColor
    }
}
