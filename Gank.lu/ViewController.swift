//
//  ViewController.swift
//  Gank.lu
//
//  Created by FIND.ME on 16/1/2.
//  Copyright © 2016年 smartalker. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher

class ViewController: UIViewController ,GankHttpDelegate{
    var data:[GirlFlow] = []
    var nextText:String?
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.dataSource = self
        tableView.delegate = self
        
        GankHttp.shareInstance.fetchGankData(2)
        GankHttp.shareInstance.delegate = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func gankDataReceived(json: AnyObject) {
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
        cell.timeLabel.text = girlFlow.updatedAt
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



