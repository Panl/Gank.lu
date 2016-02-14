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
    var loadingMore = false
    var page:Int = 0
    let tableFooterView = UIView()
    var loadMoreText = UILabel()
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.dataSource = self
        tableView.delegate = self
        GankHttp.shareInstance.fetchGankData(page)
        GankHttp.shareInstance.delegate = self
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 420
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
    }
    
    func loadMoreData(json:JSON){
        let result = json["results"].array
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



