//
//  GankCell.swift
//  Gank.lu
//
//  Created by FIND.ME on 16/2/18.
//  Copyright © 2016年 smartalker. All rights reserved.
//

import UIKit
import SwiftyJSON

class Gank {
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
class GankCell: UITableViewCell {
    
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setGankViews(gank:Gank){
        typeLabel.text = gank.type
        descLabel.text = gank.desc
    }
    
    func setGankViews(ganks:[Gank],indexPath:NSIndexPath){
        if indexPath.row == 0{
            typeLabel.hidden = false
            typeLabel.sizeToFit()
        }else {
            if ganks[indexPath.row].type == ganks[indexPath.row - 1].type{
                typeLabel.hidden = true
                typeLabel.frame.size.height = 0
            }else{
                typeLabel.hidden = false
                typeLabel.sizeToFit()
            }
        }
        typeLabel.text = ganks[indexPath.row].type
        descLabel.text = ganks[indexPath.row].desc
    }
    
    func heightForCell()->CGFloat {
        var height:CGFloat = 0.0
        if typeLabel.hidden{
            height = 16 + descLabel.frame.height
        }else{
            height = 24 + descLabel.frame.height + typeLabel.frame.height
        }
        return height
    }
}
