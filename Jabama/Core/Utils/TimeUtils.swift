//
//  TimeUtils.swift
//  Ludo
//
//  Created by mohsen mokhtari on 9/17/23.
//

import Foundation
struct TimeUtils {
    static func getRemainingDate(targetTime: Int) -> String {
        let currentTime = Date()
        let expireDate = Date(timeIntervalSince1970: Double(targetTime)/1000)
        let year = Calendar.current.dateComponents([.year], from: currentTime, to: expireDate).year
        let day = Calendar.current.dateComponents([.day], from: currentTime, to: expireDate).day
        let month = Calendar.current.dateComponents([.month], from: currentTime, to: expireDate).month
        let hour = Calendar.current.dateComponents([.hour], from: currentTime, to: expireDate).hour
        let minute = Calendar.current.dateComponents([.minute], from: currentTime, to: expireDate).minute



        if(year ?? 0 > 0) {
            return "\(year!) years"
        }
        else if (month ?? 0 > 0) {
            return "\(month!) months"
        }
        else if(day ?? 0 > 0) {
            return "\(day!) days"
        } else if(hour ?? 0 > 0) {
            return "\(hour!) hours"
        } else if(minute ?? 0 > 0) {
            return "\(minute!) minutes"
        }

        else {
            return "0 days"

        }
    }
    
    static func formatDate(_ date:String) -> String{
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let formatteddate = dateFormatterGet.date(from: date)
        return dateFormatterGet.string(from: formatteddate!)
    }
}
