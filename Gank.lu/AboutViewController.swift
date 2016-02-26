//
//  AboutViewController.swift
//  Gank.lu
//
//  Created by FIND.ME on 16/2/20.
//  Copyright © 2016年 smartalker. All rights reserved.
//

import UIKit

class AboutViewController: BaseViewController {

    let introduce = "「Gank.lu」是干货集中营的非官方iOS客户端之一，每天提供一张精选的妹纸图片，一个精选的休息视频，若干精选的Android，ios，web等相关的技术干货。主页采取了突出妹纸的卡片设计，点击图片可查看大图，点击卡片下的文字可进入每日干货，右下角的『fab』可进入纯干货页面，可根据分类浏览。\n\n本项目完全开源，由Panl完成，由于水平有限，项目中难免有所纰漏，如果有问题请与我联系 panlei106@gmail.com\n\n我的Github：https://github.com/Panl\n\n数据来源: 干货集中营 http://gank.io/api"
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var versionLabel: UILabel!
    
    @IBOutlet weak var introduceTextView: UITextView!
    @IBOutlet weak var batteryBgView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        initAboutViews()
    }
    
    func initAboutViews(){
        navigationItem.title = "About"
        batteryBgView.backgroundColor = navColor
        introduceTextView.text = introduce
        scrollView.contentInset = UIEdgeInsetsMake(0, 0, 30, 0)
    }
    
    
}
