//
//  GankModel.swift
//  Gank.lu
//
//  Created by FIND.ME on 16/2/26.
//  Copyright © 2016年 smartalker. All rights reserved.
//

import SwiftyJSON

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