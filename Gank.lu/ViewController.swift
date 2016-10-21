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
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}


class ViewController: UIViewController, GirlHttpDelegate {
    var data:[GirlFlow] = []
    var girlFlow:GirlFlow?
    var loadingMore = false
    var page:Int = 1
    var loadMoreText = UILabel()
    var batteryCenter = CGPoint(x: 0, y: 0)
    var showedPosition = 0
    var lastContentY:CGFloat = 0
    let showGank = "showGank"
    let showImage = "showImage"
    let beautyCell = "BeautyCell"
    let showBattery = "showBattery"

    @IBOutlet weak var batteryButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: beautyCell,bundle: nil), forCellReuseIdentifier: beautyCell)
        GankHttp.shareInstance.girlDelegate = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 420
        initMJRefresh()
        batteryButton.layoutIfNeeded()
        batteryCenter = batteryButton.center
    }
    
    
    func initMJRefresh(){
        let mjHeader = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(ViewController.pullToRefresh))
        mjHeader?.lastUpdatedTimeLabel!.isHidden = true
        mjHeader?.stateLabel!.textColor = UIColor.white
        tableView.mj_header = mjHeader
        tableView.mj_header.beginRefreshing()
        let mjFooter = MJRefreshBackNormalFooter(refreshingTarget: self, refreshingAction: #selector(ViewController.pullToLoadMore))
        mjFooter?.stateLabel!.textColor = UIColor.white
        tableView.mj_footer = mjFooter
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func pullToRefresh(){
        loadingMore = false
        page = 1
        GankHttp.shareInstance.fetchGirlData(page: page)
    }
    
    func pullToLoadMore(){
        loadingMore = true
        tableView.mj_footer.beginRefreshing()
        GankHttp.shareInstance.fetchGirlData(page: page)
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
    
    
    
    func refreshData(_ json:JSON){
        tableView.mj_footer.resetNoMoreData()
        tableView.mj_header.endRefreshing()
        data.removeAll()
        let result = json["results"].array
        for item in result!{
            let girl = GirlFlow(item: item)
            data.append(girl)
        }
        tableView.reloadData()
    }
    
    func loadMoreData(_ json:JSON){
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let girlFlow = data[(indexPath as NSIndexPath).row]
        let cell = tableView.dequeueReusableCell(withIdentifier: beautyCell, for: indexPath) as! BeautyCell
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        cell.setCellViews(girlFlow)
        cell.addGirlAction(indexPath,target:self, action: #selector(ViewController.showImage(_:)))
        if (indexPath as NSIndexPath).row > showedPosition {
            UIView.animate(withDuration: 0.35, animations: {
                cell.cardView.center.y -= cell.cardView.bounds.height/1.5
            })
            showedPosition = (indexPath as NSIndexPath).row
        }
        return cell
    }
    
    func showImage(_ sender:UIGestureRecognizer){
        let girlImage = sender.view as! UIImageView
        girlFlow = data[girlImage.tag]
        performSegue(withIdentifier: showImage, sender: nil)

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        girlFlow = data[(indexPath as NSIndexPath).row]
        performSegue(withIdentifier: showGank, sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == showGank {
            let gankViewController = segue.destination as! GankViewController
            gankViewController.girl
                = girlFlow
        }else if segue.identifier == showBattery{
            let batteryViewController = segue.destination
            batteryViewController.transitioningDelegate = self
            batteryViewController.modalPresentationStyle = .custom
        }else if segue.identifier == showImage{
            let girlViewController = segue.destination as! GirlViewController
            girlViewController.girl = girlFlow
        }
            
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        lastContentY = scrollView.contentOffset.y
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if lastContentY < scrollView.contentOffset.y {
            UIView.animate(withDuration: 0.15, animations: {
                self.batteryButton.center.y = self.view.bounds.height + self.batteryButton.frame.height/2 }, completion:nil)
        }else{
            UIView.animate(withDuration: 0.15, animations: {
                    self.batteryButton.center = self.batteryCenter
                    }, completion: nil)
        }
    }
    
}



