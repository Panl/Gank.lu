//
//  ViewController.swift
//  Gank.lu
//
//  Created by FIND.ME on 16/1/2.
//  Copyright © 2016年 smartalker. All rights reserved.
//  happy new year
//

import UIKit
import MJRefresh
import SwiftyJSON
import MBProgressHUD
import BubbleTransition

class ViewController: BaseViewController ,GirlHttpDelegate{
    var data:[GirlFlow] = []
    var girlUrl:GirlFlow?
    var loadingMore = false
    var page:Int = 1
    var loadMoreText = UILabel()
    let transition = BubbleTransition()
    var batteryCenter = CGPointMake(0, 0)
    var showedPosition = 0
    
    @IBOutlet weak var batteryButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.dataSource = self
        tableView.delegate = self
        tableView.registerNib(UINib(nibName: "BeautyCell",bundle: nil), forCellReuseIdentifier: "BeautyCell")
        GankHttp.shareInstance.girlDelegate = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 420
        initMJRefresh()
        let frame = batteryButton.frame
        batteryCenter = CGPointMake(frame.origin.x + frame.width/2, frame.origin.y + frame.height/2)
    }
    
    func initMJRefresh(){
        tableView.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: "pullToRefresh")
        tableView.mj_header.beginRefreshing()

        tableView.mj_footer = MJRefreshAutoFooter(refreshingTarget: self, refreshingAction: "pullToLoadMore")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func pullToRefresh(){
        loadingMore = false
        page = 1
        GankHttp.shareInstance.fetchGirlData(page)
    }
    
    func pullToLoadMore(){
        loadingMore = true
        tableView.mj_footer.beginRefreshing()
        GankHttp.shareInstance.fetchGirlData(page)
    }
    
    func girlDataReceived(json: AnyObject) {
        page += 1
        let jsonResult = JSON(json)
        if loadingMore {
            loadMoreData(jsonResult)
        }else{
            refreshData(jsonResult)
        }
    }
    
    func girlFetchFailed() {
        print("gankReceived failed")
        ToastUtil.showTextToast(self.view,toastStr: "数据加载失败...")
        if loadingMore {
            tableView.mj_footer.endRefreshing()
        }else{
            tableView.mj_header.endRefreshing()
        }
    }
    
    
    
    func refreshData(json:JSON){
        tableView.mj_header.endRefreshing()
        data.removeAll()
        let result = json["results"].array
        for item in result!{
            let girl = GirlFlow(item: item)
            data.append(girl)
        }
        tableView.reloadData()
    }
    
    func loadMoreData(json:JSON){
        tableView.mj_footer.endRefreshing()
        let result = json["results"].array
        if result?.count < 20{
           tableView.mj_footer.endRefreshingWithNoMoreData()
        }
        for item in result!{
            let girl = GirlFlow(item: item)
            data.append(girl)
        }
        tableView.reloadData()
    }
    
    
}

extension ViewController:UITableViewDataSource,UITableViewDelegate,UIViewControllerTransitioningDelegate{
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let girlFlow = data[indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier("BeautyCell", forIndexPath: indexPath) as! BeautyCell
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        cell.setCellViews(girlFlow)
        cell.addGirlAction(indexPath,target:self, action: Selector("showImage:"))
        if indexPath.row > showedPosition {
            UIView.animateWithDuration(0.5){
                cell.cardView.center.y -= cell.cardView.bounds.height/1.5
            }
        }
        showedPosition = indexPath.row
        return cell
    }
    
    func showImage(sender:UIGestureRecognizer){
        let girl = sender.view as! UIImageView
        ToastUtil.showTextToast(girl,toastStr: "点击啦...")
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        girlUrl = data[indexPath.row]
        performSegueWithIdentifier("showGank", sender: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showGank" {
            let gankViewController = segue.destinationViewController as! GankViewController
            gankViewController.girl
                = girlUrl
        }else if segue.identifier == "showBattery"{
            let batteryViewController = segue.destinationViewController
            batteryViewController.transitioningDelegate = self
            batteryViewController.modalPresentationStyle = .Custom
        }
    }
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let frame = batteryButton.frame
        batteryCenter = CGPointMake(frame.origin.x + frame.width/2, frame.origin.y + frame.height/2)
        transition.transitionMode = .Present
        transition.startingPoint = batteryCenter
        transition.bubbleColor = navColor
        return transition
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let frame = batteryButton.frame
        batteryCenter = CGPointMake(frame.origin.x + frame.width/2, frame.origin.y + frame.height/2)
        transition.transitionMode = .Dismiss
        transition.startingPoint = batteryCenter
        transition.bubbleColor = navColor
        return transition
    }
}



