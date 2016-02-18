//
//  BaseViewController.swift
//  Gank.lu
//
//  Created by FIND.ME on 16/2/18.
//  Copyright © 2016年 smartalker. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 44/255, green: 62/255, blue: 80/255, alpha: 1)
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        let navigationTitleAttribute : NSDictionary = NSDictionary(object: UIColor.whiteColor(),forKey: NSForegroundColorAttributeName)
        self.navigationController?.navigationBar.titleTextAttributes =  navigationTitleAttribute as? [String : AnyObject]
    }
}
