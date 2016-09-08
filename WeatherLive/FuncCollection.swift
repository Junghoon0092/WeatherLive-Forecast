//
//  FuncSerial.swift
//  WeatherOpen
//
//  Created by Junghoon on 2016. 8. 26..
//  Copyright © 2016년 Junghoon. All rights reserved.
//

import Foundation
import UIKit

class FuncCollection {
    
    
    func unixTimeToString(unixTime: Double, format : String) -> String {
        let temp = NSDate(timeIntervalSince1970: unixTime)
        
        let nowDate = NSDateFormatter()
        nowDate.locale = NSLocale(localeIdentifier: NSLocale.currentLocale().localeIdentifier )
        nowDate.dateFormat = format
        // "YYYY.MM.dd HH:mm a"

        let doulbeToString = nowDate.stringFromDate(temp)
        return doulbeToString
    }
    
    
}

