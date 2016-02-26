//
//  DateUtil.swift
//  Gank.lu
//
//  Created by FIND.ME on 16/2/18.
//  Copyright © 2016年 smartalker. All rights reserved.
//

import Foundation
import AFDateHelper

class DateUtil {
    static let calendar = NSCalendar.currentCalendar()
    static let dateFormatter = NSDateFormatter()
    static func stringToDate(dateStr:String)->NSDate{
        return NSDate(fromString:  dateStr, format: .ISO8601(ISO8601Format.DateTimeMilliSec))
    }
    
    static func dateToString(date:NSDate,dateFormat:String)->String{
        dateFormatter.dateFormat = dateFormat
        return dateFormatter.stringFromDate(date)
    }
    
    static func componentsFromDate(date:NSDate)->NSDateComponents{
        return calendar.components([NSCalendarUnit.Day, NSCalendarUnit.Month, NSCalendarUnit.Year], fromDate: date)
    }
}