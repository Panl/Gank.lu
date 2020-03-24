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

struct GankData: Codable {
  var _id: String
  var author: String
  var category: String
  var content: String
  var createAt: String
  var desc: String
  var images: [String]
  var likeCounts: Int
  var publishedAt: String
  var stars: Int
  var title: String
  var type: String
  var url: String
  var views: Int
}

struct GankResult: Codable {
  var data: [GankData]
  var status: Int
}




