//
//  CategoryViewController.swift
//  Gank.lu
//
//  Created by FIND.ME on 16/2/26.
//  Copyright © 2016年 smartalker. All rights reserved.
//

import UIKit
import SwiftyJSON
import MJRefresh
import SafariServices

class CategoryViewController: UITableViewController {
    let reuseableIndentifier = "categoryCell"
    var category:String = ""
    var gankData = [Gank]()
    var page = 1
    var loadingMore = false
    
    convenience init(category:String){
        self.init()
        self.category = category
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.registerNib(UINib(nibName: "CategoryCell",bundle: nil), forCellReuseIdentifier: reuseableIndentifier)
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 40
        initMJRefresh()
    }
    
    func initMJRefresh(){
        let MJHeader = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(CategoryViewController.pullToRefresh))
        MJHeader.lastUpdatedTimeLabel!.hidden = true
        tableView.mj_header = MJHeader
        tableView.mj_header.beginRefreshing()
        
        tableView.mj_footer = MJRefreshBackNormalFooter(refreshingTarget: self, refreshingAction: #selector(CategoryViewController.pullToLoadMore))
    }
    
    func pullToRefresh(){
        loadingMore = false
        page = 1
        GankHttp.shareInstance.fetchGankWithCategory(category, page: page){
            success,result in
            if success{
                self.page += 1
                let jsonResult = JSON(result!)
                self.refreshData(jsonResult)
            }else{
                self.tableView.mj_header.endRefreshing()
                ToastUtil.showTextToast(self.view, toastStr: "数据加载失败...")
            }
            self.tableView.mj_footer.resetNoMoreData()
        }
    }
    
    func pullToLoadMore(){
        loadingMore = true
        tableView.mj_footer.beginRefreshing()
        GankHttp.shareInstance.fetchGankWithCategory(category, page: page){
            success,result in
            if success{
                self.page += 1
                let jsonResult = JSON(result!)
                self.loadMoreData(jsonResult)
            }else{
                self.tableView.mj_footer.endRefreshing()
                ToastUtil.showTextToast(self.view, toastStr: "数据加载失败...")
            }
        }

    }

    
    func refreshData(json:JSON){
        tableView.mj_header.endRefreshing()
        gankData.removeAll()
        let result = json["results"].array
        for item in result!{
            let gank = Gank(item: item)
            gankData.append(gank)
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
            let gank = Gank(item: item)
            gankData.append(gank)
        }
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gankData.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(reuseableIndentifier, forIndexPath: indexPath) as! CategoryCell
        cell.gankDescLabel.text = gankData[indexPath.row].desc
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let url = gankData[indexPath.row].url
        let SFSafari = SFSafariViewController(URL: NSURL(string:url)!, entersReaderIfAvailable: true)
        self.presentViewController(SFSafari, animated: true, completion: nil)
    }
    
}
