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

class ViewController: UIViewController ,GankHttpDelegate{
    var data:[GirlFlow] = []
    var nextText:String?
    var refreshControl:UIRefreshControl?
    var refreshing:Bool = false{
        didSet{
            if self.refreshing {
                self.refreshControl!.beginRefreshing()
                self.refreshControl!.attributedTitle = NSAttributedString(string: "Loading...")
            }else{
                self.refreshControl!.endRefreshing()
                self.refreshControl!.attributedTitle = NSAttributedString(string: "Pull to refresh")
            }
        }
    }
    
    var loadingMore:Bool = false{
        didSet{
            if !self.loadingMore{
               loadMoreText.text = "上拉加载更多"
            }
        }
    }
    var page:Int = 0
    let tableFooterView = UIView()
    var loadMoreText = UILabel()
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.dataSource = self
        tableView.delegate = self
        refreshControl = UIRefreshControl()
        self.refreshControl?.addTarget(self, action: "pullToRefresh", forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.addSubview(refreshControl!)
        
        GankHttp.shareInstance.fetchGankData(page)
        GankHttp.shareInstance.delegate = self
        refreshing = true;
        
        createTableFooter()
    }
    
    func createTableFooter(){//初始化tv的footerView
        
        tableFooterView.frame = CGRectMake(0, 0, self.tableView.bounds.size.width, 60)
        loadMoreText.frame =  CGRectMake(0, 0, self.tableView.bounds.size.width, 60)
        loadMoreText.text = "上拉查看更多"
        
        loadMoreText.textAlignment = NSTextAlignment.Center
        
        tableFooterView.addSubview(loadMoreText)
        
        self.tableView.tableFooterView = tableFooterView
    }
    
    func pullToRefresh(){
        refreshing = true
        page = 0
        GankHttp.shareInstance.fetchGankData(page)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func gankDataReceived(json: AnyObject) {
        let jsonResult = JSON(json)
        page++
        if loadingMore{
            loadMoreData(jsonResult)
        }else{
            refreshData(jsonResult)
        }
    }
    
    func refreshData(json:JSON){
        data.removeAll()
        let result = json["results"].array
        for item in result!{
            let girl = GirlFlow(item: item)
            data.append(girl)
        }
        tableView.reloadData()
        refreshing = false
    }
    
    func loadMoreData(json:JSON){
        let result = json["results"].array
        for item in result!{
            let girl = GirlFlow(item: item)
            data.append(girl)
        }
        tableView.reloadData()
        loadingMore = false
    }
    
    
}

extension ViewController:UITableViewDataSource,UITableViewDelegate{
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("girlCell",forIndexPath:indexPath) as! GirlCell
        let girlFlow = data[indexPath.row]
        cell.girlImageView.kf_setImageWithURL(NSURL(string: girlFlow.url)!)
        cell.nickNameLabel.text = girlFlow.who
        cell.timeLabel.text = girlFlow.publishedAt
        cell.contentLabel.text = girlFlow.desc
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
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if scrollView.contentOffset.y > (scrollView.contentSize.height - scrollView.frame.size.height + 30){
            loadMoreText.text = "松开载入更多"
        }else{
            loadMoreText.text = "上拉查看更多"
        }
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView.contentOffset.y > (scrollView.contentSize.height - scrollView.frame.size.height + 30){
            loadingMore = true
            GankHttp.shareInstance.fetchGankData(page)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showNext" {
            let nextViewController = segue.destinationViewController as! NextViewController
            nextViewController.nextText
                = nextText
        }
    }
}



