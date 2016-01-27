//
//  NextViewController.swift
//  Gank.lu
//
//  Created by FIND.ME on 16/1/6.
//  Copyright © 2016年 smartalker. All rights reserved.
//

import UIKit

class NextViewController: UIViewController {

    @IBOutlet weak var nextLabel: UILabel!
    var nextText:String?
    override func viewDidLoad() {
        super.viewDidLoad()
        nextLabel.text = nextText
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

}
