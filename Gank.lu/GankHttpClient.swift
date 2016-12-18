//
//  GankHttpClient.swift
//  Gank.lu
//
//  Created by FIND.ME on 16/1/10.
//  Copyright © 2016年 smartalker. All rights reserved.
//

import Alamofire
protocol GankHttpDelegate{
    func gankDataReceived(_ json:AnyObject)
    func gankFetchFailed()
}

protocol GirlHttpDelegate{
    func girlDataReceived(_ json:AnyObject)
    func girlFetchFailed()
}
class GankHttp {
    let baseUrl = "http://gank.io/api/"
    let requestNumber = 20
    fileprivate static let singleInstance = GankHttp()
    var delegate:GankHttpDelegate?
    var girlDelegate:GirlHttpDelegate?
    class var shareInstance : GankHttp {
        return singleInstance
    }
    
    func fetchGirlData(_ page:Int){
        let requestUrl = (baseUrl + "data/福利/\(requestNumber)/\(page)").addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)
        print(requestUrl ?? "")
        
        Alamofire.request(requestUrl!, method: .get).responseJSON{
            response in
            print("Debug",response)
            guard let json = response.result.value else{
                self.girlDelegate?.girlFetchFailed()
                return
            }
            print("Debug",response)
            self.girlDelegate?.girlDataReceived(json as AnyObject)
        }
    }
    
    func fetchGankDataAtYear(_ year:Int,month:Int,day:Int){
        let requestUrl = (baseUrl + "day/\(year)/\(month)/\(day)").addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)
        print(requestUrl ?? "")
        Alamofire.request(requestUrl!, method: .get).responseJSON(){
            response in
            guard let json = response.result.value else {
                self.delegate?.gankFetchFailed()
                return
            }
            self.delegate?.gankDataReceived(json as AnyObject)
        }
    }
    
    func fetchGankWithCategory(_ category:String,page:Int,complete:@escaping (_ success:Bool,_ result:AnyObject?)->Void){
        let url = (baseUrl + "data/\(category)/\(requestNumber)/\(page)").addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)
        debugPrint(url ?? "")
        Alamofire.request(url!, method: .get).responseJSON{response in
            guard let json = response.result.value else {
                complete(false, nil)
                return
            }
            complete(true, json as AnyObject?)
        }
    }
}
