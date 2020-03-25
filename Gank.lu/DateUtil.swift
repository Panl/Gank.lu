//
//  DateUtil.swift
//  Gank.lu
//
//  Created by FIND.ME on 16/2/18.
//  Copyright © 2016年 smartalker. All rights reserved.
//

import Foundation

class DateUtil {

  static let calendar = Calendar.current
  static let dateFormatter = DateFormatter()

  static func stringToDate(_ dateStr:String)->Date{
    dateFormatter.timeZone = TimeZone(identifier: "UTC")
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    return dateFormatter.date(from: dateStr)!
  }

  static func stringToDate(_ dateStr:String, dateFormat:String)->Date {
    dateFormatter.timeZone = TimeZone(identifier: "UTC")
    dateFormatter.dateFormat = dateFormat
    return dateFormatter.date(from: dateStr)!
  }

  static func dateToString(_ date:Date,dateFormat:String)->String{
    dateFormatter.dateFormat = dateFormat
    return dateFormatter.string(from: date)
  }

  static func stringToRelative(_ dataStar: String) -> String {
    let date = stringToDate(dataStar)
    let timeZone = TimeZone.current
    let now = Date()
    let interval: Int = timeZone.secondsFromGMT(for: now)
    let currentDate = now.addingTimeInterval(Double(interval))
    let timeInterval = currentDate.timeIntervalSince(date)
    if timeInterval < 0 {
      return dateToString(date, dateFormat: "yyy年M月d日")
    } else if timeInterval < 60  {
      return "\(Int(timeInterval)) 秒钟前"
    } else if timeInterval < 60 * 60 {
      return "\(Int(timeInterval / 60)) 分钟前"
    } else if timeInterval < 24 * 60 * 60 {
      return "\(Int(timeInterval / (60 * 60))) 小时前"
    } else if timeInterval < 15 * 24 * 60 * 60  {
      return "\(Int(timeInterval / (24 * 60 * 60))) 天前"
    } else {
      return dateToString(date, dateFormat: "yyy年M月d日")
    }
  }



  static func componentsFromDate(_ date:Date)->DateComponents{
    return (calendar as NSCalendar).components([NSCalendar.Unit.day, NSCalendar.Unit.month, NSCalendar.Unit.year], from: date)
  }
}
