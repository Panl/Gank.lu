//
//  GirlViewController.swift
//  Gank.lu
//
//  Created by FIND.ME on 16/2/26.
//  Copyright © 2016年 smartalker. All rights reserved.
//

import UIKit
import Kingfisher

class GirlViewController: BaseViewController,UIScrollViewDelegate
{
    var girlUrl:String?
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var girlImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.automaticallyAdjustsScrollViewInsets = false
        self.scrollView.minimumZoomScale = 1.0
        self.scrollView.maximumZoomScale = 4.0
        self.scrollView.delegate = self
        girlImageView.kf_setImageWithURL(NSURL(string: girlUrl!)!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return self.girlImageView
    }

}
