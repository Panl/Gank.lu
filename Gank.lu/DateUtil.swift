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
        return Date()
    }
    
    static func dateToString(_ date:Date,dateFormat:String)->String{
        dateFormatter.dateFormat = dateFormat
        return dateFormatter.string(from: date)
    }
    
    static func componentsFromDate(_ date:Date)->DateComponents{
        return (calendar as NSCalendar).components([NSCalendar.Unit.day, NSCalendar.Unit.month, NSCalendar.Unit.year], from: date)
    }
}
