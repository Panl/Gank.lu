//
//  Models.swift
//  Gank.lu
//
//  Created by Lei Pan on 2020/3/25.
//  Copyright © 2020 smartalker. All rights reserved.
//

import Combine
import Foundation

class BannerObserver: ObservableObject {
  @Published var banners = [BannerData]()

  func fetchBanners() {
    GankHttp.shareInstance.fetchGankBanner { resp in
      if let json = resp.data {
        do {
          let bannerResult = try JSONDecoder().decode(BannerResult.self, from: json)
          self.banners.append(contentsOf: bannerResult.data)
        } catch let error {
          print("error", error)
        }
      }
    }
  }
}

class GankObserver: ObservableObject {
  @Published var ganks = [GankData]()

  func fetchBanners() {
    GankHttp.shareInstance.fetchAllGank(page: 1, count: 20) { resp in
      if let json = resp.data {
        do {
          let gankResult = try JSONDecoder().decode(GankResult.self, from: json)
          self.ganks.append(contentsOf: gankResult.data)
        } catch let error {
          print("error", error)
        }
      }
    }
  }
}

