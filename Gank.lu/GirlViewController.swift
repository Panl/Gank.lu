//
//  GirlViewController.swift
//  Gank.lu
//
//  Created by FIND.ME on 16/2/26.
//  Copyright © 2016年 smartalker. All rights reserved.
//

import UIKit
import Kingfisher

class GirlViewController: UIViewController, UIScrollViewDelegate {
    
    var girl:GirlFlow?
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var girlImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.scrollView.minimumZoomScale = 1.0
        self.scrollView.maximumZoomScale = 4.0
        self.scrollView.delegate = self
        girlImageView.kf_setImageWithURL(NSURL(string: (girl?.url)!)!)
       
        let date = DateUtil.stringToDate((girl?.publishedAt)!)
        self.title = DateUtil.dateToString(date, dateFormat: "yyyy/MM/dd")

    }
    @IBAction func shareAction(sender: UIBarButtonItem) {
        let message = "发现了一款看妹子的小app「Gank.lu」,  同时有很多程序员干货哦，^_^"
        let urlToShare = NSURL(string: "https://github.com/Panl/Gank.lu")
        let vc = UIActivityViewController(activityItems: [message,girlImageView.image!,urlToShare!], applicationActivities: nil)
        self.presentViewController(vc, animated: true, completion: nil)
    }
    @IBAction func saveGirl(sender: AnyObject) {
        UIImageWriteToSavedPhotosAlbum(girlImageView.image!, self, Selector("image:didFinishSavingWithError:contextInfo:"), nil)
    }
    
    func image(image:UIImage,didFinishSavingWithError:NSError,contextInfo:AnyObject){
        ToastUtil.showTextToast(self.scrollView, toastStr: "保存成功")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return self.girlImageView
    }

}
