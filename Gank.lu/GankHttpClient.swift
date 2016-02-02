//
//  GankHttpClient.swift
//  Gank.lu
//
//  Created by FIND.ME on 16/1/10.
//  Copyright © 2016年 smartalker. All rights reserved.
//

import Alamofire
protocol GankHttpDelegate{
    func gankDataReceived(json:AnyObject)
}
class GankHttp {
    
    private static let singleInstance = GankHttp()
    var delegate:GankHttpDelegate?
    
    class var shareInstance : GankHttp {
        return singleInstance
    }
    
    func fetchGankData(page:Int){
        let requestUrl = "http://gank.avosapps.com/api/data/福利/20/\(page)".stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLFragmentAllowedCharacterSet())
        Alamofire.request(.GET, requestUrl!).responseJSON(){
            response in self.delegate?.gankDataReceived(response.result.value!)
        }
    }
}
