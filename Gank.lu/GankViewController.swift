//
//  NextViewController.swift
//  Gank.lu
//
//  Created by FIND.ME on 16/1/6.
//  Copyright © 2016年 smartalker. All rights reserved.
//

import UIKit
import SwiftyJSON
import MBProgressHUD
import SafariServices

class GankViewController: BaseViewController ,GankHttpDelegate{

    @IBOutlet weak var tableView: UITableView!
    var topImageHeight:CGFloat = 220
    var girl:GirlFlow?
    var topImageView:UIImageView!
    var gankData:[Gank] = []
    var hud:MBProgressHUD?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initTableView()
        initGankHttp()
    }
    
    @IBAction func refreshGank(sender: AnyObject) {
        showProgress()
        let date = DateUtil.stringToDate((girl?.publishedAt)!)
        let components = DateUtil.componentsFromDate(date)
        GankHttp.shareInstance.fetchGankDataAtYear(components.year, month: components.month, day: components.day)
    }
    func initTableView(){
        topImageHeight = self.view.bounds.width * 0.65
        topImageView = UIImageView(frame: CGRect(x: 0, y: -topImageHeight, width: self.view.bounds.width, height: topImageHeight))
        topImageView.kf_setImageWithURL(NSURL(string: (girl?.url)!)!)
        topImageView.contentMode = .ScaleAspectFill
        topImageView.clipsToBounds = true
        tableView.delegate = self
        tableView.dataSource = self
        tableView.contentInset = UIEdgeInsetsMake(topImageHeight, 0, 30, 0)
        tableView.addSubview(topImageView)
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 180
        let date = DateUtil.stringToDate((girl?.publishedAt)!)
        self.navigationItem.title = DateUtil.dateToString(date, dateFormat: "yyyy/MM/dd")
    }
    
    func initGankHttp(){
        let date = DateUtil.stringToDate((girl?.publishedAt)!)
        let components = DateUtil.componentsFromDate(date)
        GankHttp.shareInstance.delegate = self
        GankHttp.shareInstance.fetchGankDataAtYear(components.year, month: components.month, day: components.day)
        showProgress()
    }
    func showProgress(){
        hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        hud!.labelText = "loading..."
        hud!.dimBackground = true
    }
    func gankDataReceived(json: AnyObject) {
        debugPrint(json)
        hud?.hide(true)
        let resultJosn = JSON(json)
        refreshData(resultJosn)
    }

    func refreshData(json:JSON){
        gankData.removeAll()
        let categorys = json["category"].array
        let result = json["results"]
        for category in categorys!{
            if category.stringValue == "福利"{
                continue
            }
            let ganks = result[category.stringValue].array
            for gank in ganks!{
                gankData.append(Gank(item: gank))
            }
        }
        tableView.reloadData()
        
    }
    
    func gankFetchFailed() {
        print("failed")
        hud?.hide(true)
        ToastUtil.showTextToast(self.view,toastStr: "数据加载失败...")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension GankViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gankData.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCellWithIdentifier("gankCell",forIndexPath:indexPath) as! GankCell
        cell.setGankViews(gankData[indexPath.row])
        return cell
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let url = gankData[indexPath.row].url
        let SFSafari = SFSafariViewController(URL: NSURL(string:url)!, entersReaderIfAvailable: true)
        self.presentViewController(SFSafari, animated: true, completion: nil)
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        if offsetY < -topImageHeight{
            topImageView.frame.origin.y = offsetY
            topImageView.frame.size.height = -offsetY
        }
    }
    
}
