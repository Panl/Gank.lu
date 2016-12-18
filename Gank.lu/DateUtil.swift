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
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
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
    
    static func componentsFromDate(_ date:Date)->DateComponents{
        return (calendar as NSCalendar).components([NSCalendar.Unit.day, NSCalendar.Unit.month, NSCalendar.Unit.year], from: date)
    }
}
