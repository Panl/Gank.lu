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
                print("Loading...")
            }else{
                self.refreshControl!.endRefreshing()
                self.refreshControl!.attributedTitle = NSAttributedString(string: "Pull to refresh")
                print("Loaded & set:Pull to Refresh")
            }
        }
    }
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.dataSource = self
        tableView.delegate = self
        refreshControl = UIRefreshControl()
        self.refreshControl?.addTarget(self, action: "pullToRefresh", forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.addSubview(refreshControl!)
        
        GankHttp.shareInstance.fetchGankData(0)
        GankHttp.shareInstance.delegate = self
        refreshing = true;
    }
    
    func pullToRefresh(){
        GankHttp.shareInstance.fetchGankData(0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func gankDataReceived(json: AnyObject) {
        refreshing = false
        let jsonResult = JSON(json)
        jsonParse(jsonResult)
    }
    
    func jsonParse(json:JSON){
        let result = json["results"].array
        debugPrint(result)
        for item in result!{
            let updateAt = item["updateAt"].stringValue
            let who = item["who"].stringValue
            let objectId = item["objectId"].stringValue
            let publishedAt = item["publishedAt"].stringValue
            let used = item["used"].boolValue
            let createdAt = item["createdAt"].stringValue
            let url = item["url"].stringValue
            let desc = item["desc"].stringValue
            let type = item["type"].stringValue
            let girl = GirlFlow(updatedAt: updateAt,who: who,publishedAt: publishedAt,objectId: objectId,used: used,type: type,createdAt: createdAt,desc: desc,url: url)
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
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showNext" {
            let nextViewController = segue.destinationViewController as! NextViewController
            nextViewController.nextText
                = nextText
        }
    }
}



