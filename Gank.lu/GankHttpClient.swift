//
//  GankHttpClient.swift
//  Gank.lu
//
//  Created by FIND.ME on 16/1/10.
//  Copyright © 2016年 smartalker. All rights reserved.
//

import Alamofire

class GankHttp {
  let baseUrl = "https://gank.io/api/v2"
  fileprivate static let singleInstance = GankHttp()
  class var shareInstance : GankHttp {
    return singleInstance
  }

  func fetchGankBanner(completionHandler: @escaping (AFDataResponse<Any>) -> Void) {
    let url = "https://gank.io/api/v2/banners"
    AF.request(url, method: .get).validate().responseJSON { resp in
      completionHandler(resp)
    }
  }

  func fetchAllGank(page: Int, count: Int, completionHandler: @escaping (AFDataResponse<Any>) -> Void) {
    let url = "https://gank.io/api/v2/data/category/All/type/All/page/\(page)/count/\(count)"
    AF.request(url, method: .get).validate().responseJSON { resp in
      completionHandler(resp)
    }
  }
}
