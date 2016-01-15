//
//  ViewController.swift
//  Gank.lu
//
//  Created by FIND.ME on 16/1/2.
//  Copyright © 2016年 smartalker. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    let data = [
        GirlFlow(avatar: "avatar", image: "views", nickName: "SmartTalk", userName: "panlei", content: "我是一个追求梦想的人，在逐梦的道路上一直坚持不懈的努力着，天道酬勤，后会有期", created_at: "1 min ago"),
        GirlFlow(avatar: "avatar", image: "bulesky", nickName: "SmartTalk", userName: "panlei", content: "我是一个追求梦想的人，在逐梦的道路上一直坚持不懈的努力着，天道酬勤，后会有期", created_at: "1 min ago"),
        GirlFlow(avatar: "avatar", image: "bulesky", nickName: "SmartTalk", userName: "panlei", content: "我是一个追求梦想的人，在逐梦的道路上一直坚持不懈的努力着，天道酬勤，后会有期", created_at: "1 min ago"),
        GirlFlow(avatar: "avatar", image: "meizi", nickName: "SmartTalk", userName: "panlei", content: "我是一个追求梦想的人，在逐梦的道路上一直坚持不懈的努力着，天道酬勤，后会有期", created_at: "1 min ago")
    ]
    var nextText:String?
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.dataSource = self
        tableView.delegate = self
        
        GankHttp.shareInstance.fetchGankData(2)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

extension ViewController:UITableViewDataSource,UITableViewDelegate{
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("girlCell",forIndexPath:indexPath) as! GirlCell
        let girlFlow = data[indexPath.row]
        cell.girlImageView.image = UIImage(imageLiteral: girlFlow.image)
        cell.avatarImageView.image = UIImage(imageLiteral: girlFlow.avatar)
        cell.nickNameLabel.text = girlFlow.nickName
        cell.userNameLabel.text = girlFlow.userName
        cell.timeLabel.text = girlFlow.created_at
        cell.contentLabel.text = girlFlow.content
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



