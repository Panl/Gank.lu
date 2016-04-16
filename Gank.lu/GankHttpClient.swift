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
    func gankFetchFailed()
}

protocol GirlHttpDelegate{
    func girlDataReceived(json:AnyObject)
    func girlFetchFailed()
}
class GankHttp {
    let baseUrl = "http://gank.io/api/"
    let requestNumber = 20
    private static let singleInstance = GankHttp()
    var delegate:GankHttpDelegate?
    var girlDelegate:GirlHttpDelegate?
    class var shareInstance : GankHttp {
        return singleInstance
    }
    
    func fetchGirlData(page:Int){
        let requestUrl = (baseUrl + "data/福利/\(requestNumber)/\(page)").stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLFragmentAllowedCharacterSet())
        
        print(requestUrl)
        
        Alamofire.request(.GET, requestUrl!).responseJSON(){
            response in
            guard let json = response.result.value else{
                self.girlDelegate?.girlFetchFailed()
                return
            }
            self.girlDelegate?.girlDataReceived(json)
        }
    }
    
    func fetchGankDataAtYear(year:Int,month:Int,day:Int){
        let requestUrl = baseUrl + "day/\(year)/\(month)/\(day)"
        print(requestUrl)
        Alamofire.request(.GET, requestUrl).responseJSON(){
            response in
            guard let json = response.result.value else {
                self.delegate?.gankFetchFailed()
                return
            }
            self.delegate?.gankDataReceived(json)
        }
    }
    
    func fetchGankWithCategory(category:String,page:Int,complete:(success:Bool,result:AnyObject?)->Void){
        let url = baseUrl + "data/\(category)/\(requestNumber)/\(page)"
        let requestUrl = url.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLFragmentAllowedCharacterSet())
        debugPrint(requestUrl)
        Alamofire.request(.GET, requestUrl!).responseJSON{response in
            guard let json = response.result.value else {
                complete(success:false, result: nil)
                return
            }
            complete(success: true, result: json)
        }
    }
}
