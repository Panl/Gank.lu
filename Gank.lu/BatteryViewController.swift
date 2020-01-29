//
//  BatteryViewController.swift
//  Gank.lu
//
//  Created by FIND.ME on 16/2/21.
//  Copyright © 2016年 smartalker. All rights reserved.
//

import UIKit
import PagingKit

let tabTitles = ["Android","iOS","前端","瞎推荐","拓展资源","App"]


class BatteryViewController: UIViewController {

    
    override func viewDidLoad(){
        super.viewDidLoad()
        
//        let options = PagingMenuOptions()
//        let pagingMenuController = PagingMenuController(options: options)
//        pagingMenuController.view.frame.origin.y += 64
//        pagingMenuController.view.frame.size.height -= 64
//
//        addChildViewController(pagingMenuController)
//        view.addSubview(pagingMenuController.view)
//        pagingMenuController.didMove(toParentViewController: self)
    }
    
    
    @IBAction func backToGril(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
}


