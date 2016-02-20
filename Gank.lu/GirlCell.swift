//
//  GirlCell.swift
//  Gank.lu
//
//  Created by FIND.ME on 16/1/6.
//  Copyright © 2016年 smartalker. All rights reserved.
//

import UIKit
import SwiftyJSON
import Kingfisher

class GirlFlow {
    let updatedAt:String
    let who:String
    let publishedAt:String
    let objectId:String
    let used:Bool
    let type:String
    let createdAt:String
    let desc:String
    let url:String
    
    init(item:JSON){
        updatedAt = item["updateAt"].stringValue
        who = item["who"].stringValue
        objectId = item["objectId"].stringValue
        publishedAt = item["publishedAt"].stringValue
        used = item["used"].boolValue
        createdAt = item["createdAt"].stringValue
        url = item["url"].stringValue
        desc = item["desc"].stringValue
        type = item["type"].stringValue
    }
    
}

class GirlCell: UITableViewCell {

    @IBOutlet weak var girlImageView: UIImageView!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func setCellViews(girlFlow:GirlFlow){
        self.girlImageView.kf_setImageWithURL(NSURL(string: girlFlow.url)!)
        self.nickNameLabel.text = girlFlow.who
        let date = DateUtil.stringToDate(girlFlow.publishedAt)
        self.timeLabel.text = DateUtil.dateToString(date, dateFormat: "yyyy年MM月dd日")
        self.contentLabel.text = girlFlow.desc
    }
    
    func addGirlAction(indexPath:NSIndexPath,target:AnyObject,action:Selector){
        girlImageView.userInteractionEnabled = true
        girlImageView.tag = indexPath.row
        let tap = UITapGestureRecognizer(target: target, action: action)
        girlImageView.addGestureRecognizer(tap)
    }

}
