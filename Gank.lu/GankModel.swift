//
//  GankModel.swift
//  Gank.lu
//
//  Created by FIND.ME on 16/2/26.
//  Copyright © 2016年 smartalker. All rights reserved.
//

struct BannerData: Codable {
  var image: String
  var title: String
  var url: String
}

struct BannerResult: Codable {
  var data: [BannerData]
  var status: Int
}

struct GankData: Codable, Hashable {
  var _id: String
  var author: String
  var category: String
  var createdAt: String
  var desc: String
  var images: [String?]
  var likeCounts: Int
  var publishedAt: String
  var stars: Int
  var title: String
  var type: String
  var url: String
  var views: Int

  var cover: String {
    if images.isEmpty {
      return ""
    } else {
      return images[0] ?? ""
    }
  }
}

struct GankResult: Codable {
  var data: [GankData]
  var status: Int
}




