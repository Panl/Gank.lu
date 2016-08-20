//
//  BatteryViewController.swift
//  Gank.lu
//
//  Created by FIND.ME on 16/2/21.
//  Copyright © 2016年 smartalker. All rights reserved.
//

import UIKit
import PagingMenuController

let tabTitles = ["Android","iOS","前端","瞎推荐","拓展资源","App"]

private struct PagingMenuOptions : PagingMenuControllerCustomizable {
    
    private var componentType: ComponentType {
        return .All(menuOptions: MenuOptions(), pagingControllers: pagingControllers)
    }
    
    private var pagingControllers: [UIViewController] {
        var viewControllers = [UIViewController]()
        for title in tabTitles {
            let viewController = CategoryViewController(category: title)
            viewController.title = title
            viewControllers.append(viewController)
        }
        return viewControllers
    }
    
    
    private struct MenuOptions: MenuViewCustomizable {
        var displayMode: MenuDisplayMode {
            return .SegmentedControl
        }
        var backgroundColor: UIColor {
            return navColor
        }
        var selectedBackgroundColor: UIColor {
            return navColor
        }
        
        var height: CGFloat {
            return 40
        }
        var itemsOptions: [MenuItemViewCustomizable] {
            var menuItems = [MenuItemViewCustomizable]()
            for title in tabTitles {
                menuItems.append(MenuItem(displayTitle: title))
            }
            return menuItems
        }
    }
    
    private struct MenuItem: MenuItemViewCustomizable {
        var displayTitle = ""
        init(displayTitle:String){
            self.displayTitle = displayTitle
        }
        var displayMode: MenuItemDisplayMode {
            return .Text(title: MenuItemText(text: displayTitle, selectedColor: UIColor.whiteColor()))
        }
    }
}

class BatteryViewController: UIViewController {

    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        let options = PagingMenuOptions()        
        let pagingMenuController = PagingMenuController(options: options)
        pagingMenuController.view.frame.origin.y += 64
        pagingMenuController.view.frame.size.height -= 64
        
        addChildViewController(pagingMenuController)
        view.addSubview(pagingMenuController.view)
        pagingMenuController.didMoveToParentViewController(self)
    }
    
    
    @IBAction func backToGril(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}


