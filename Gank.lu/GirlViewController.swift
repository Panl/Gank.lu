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
        girlImageView.kf.setImage(with: URL(string: (girl?.url)!)!)
       
        let date = DateUtil.stringToDate((girl?.publishedAt)!)
        self.title = DateUtil.dateToString(date, dateFormat: "yyyy/MM/dd")

    }
    @IBAction func shareAction(_ sender: UIBarButtonItem) {
        let message = "发现了一款看妹子的小app「Gank.lu」, 同时有很多程序员干货哦，^_^"
        let urlToShare = URL(string: "https://github.com/Panl/Gank.lu")
        let vc = UIActivityViewController(activityItems: [message,girlImageView.image!,urlToShare!], applicationActivities: nil)
        self.present(vc, animated: true, completion: nil)
    }
    @IBAction func saveGirl(_ sender: AnyObject) {
        UIImageWriteToSavedPhotosAlbum(girlImageView.image!, self, #selector(GirlViewController.image(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    @objc func image(_ image:UIImage,didFinishSavingWithError:NSError,contextInfo:AnyObject){
        //TODO 判断一些事情
        ToastUtil.showTextToast(self.scrollView, toastStr: "保存成功")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.girlImageView
    }

}
