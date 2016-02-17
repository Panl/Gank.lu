//
//  ViewController.swift
//  Gank.lu
//
//  Created by FIND.ME on 16/1/2.
//  Copyright © 2016年 smartalker. All rights reserved.
//  happy new year
//

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher
import MJRefresh

class ViewController: UIViewController ,GankHttpDelegate{
    var data:[GirlFlow] = []
    var nextText:String?
    var loadingMore = false
    var page:Int = 1
    let tableFooterView = UIView()
    var loadMoreText = UILabel()
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.dataSource = self
        tableView.delegate = self
        GankHttp.shareInstance.delegate = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 420
        initMJRefresh()
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
        GankHttp.shareInstance.fetchGankData(page)
    }
    
    func pullToLoadMore(){
        loadingMore = true
        tableView.mj_footer.beginRefreshing()
        GankHttp.shareInstance.fetchGankData(page)
    }
    
    func gankDataReceived(json: AnyObject) {
        page++
        let jsonResult = JSON(json)
        if loadingMore {
            loadMoreData(jsonResult)
        }else{
            refreshData(jsonResult)
        }
    }
    
    func gankFetchFailed() {
        print("gankReceived failed")
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

extension ViewController:UITableViewDataSource,UITableViewDelegate{
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("girlCell",forIndexPath:indexPath) as! GirlCell
        let girlFlow = data[indexPath.row]
        cell.setCellViews(girlFlow)
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! GirlCell
        nextText = cell.contentLabel.text
        performSegueWithIdentifier("showNext", sender: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showNext" {
            let nextViewController = segue.destinationViewController as! NextViewController
            nextViewController.nextText
                = nextText
        }
    }
}



