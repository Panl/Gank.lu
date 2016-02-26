//
//  BatteryViewController.swift
//  Gank.lu
//
//  Created by FIND.ME on 16/2/21.
//  Copyright © 2016年 smartalker. All rights reserved.
//

import UIKit
import PagingMenuController

class BatteryViewController:BaseViewController{

    
    let tabTitles = ["Android","iOS","前端","瞎推荐","拓展资源","App"]
    var viewControllers = [UIViewController]()
    
    override func viewDidLoad(){
        super.viewDidLoad()
        for title in tabTitles {
            let viewController = CategoryViewController(category: title)
            viewController.title = title
            viewControllers.append(viewController)
        }
        let options = PagingMenuOptions()
        options.menuHeight = 40
        options.menuDisplayMode = .Standard(widthMode: .Flexible, centerItem: false, scrollingMode: .ScrollEnabled)
        options.backgroundColor = navColor
        options.selectedBackgroundColor = navColor
        options.selectedTextColor = UIColor.whiteColor()
        options.menuItemMode = .Underline(height: 3, color: UIColor.redColor(), horizontalPadding: 0, verticalPadding: 0)
        let pagingMenuController = self.childViewControllers.first as! PagingMenuController
        pagingMenuController.setup(viewControllers: viewControllers, options: options)
    }
    
    
    @IBAction func backToGril(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}


