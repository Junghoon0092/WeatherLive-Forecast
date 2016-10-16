//
//  FuncSerial.swift
//  WeatherOpen
//
//  Created by Junghoon on 2016. 8. 26..
//  Copyright © 2016년 Junghoon. All rights reserved.
//

import Foundation
import UIKit

extension Double {
    
    func unixTimeToString(format : String) -> String {
        let temp = NSDate(timeIntervalSince1970: self)
        
        let nowDate = NSDateFormatter()
        nowDate.locale = NSLocale(localeIdentifier: NSLocale.currentLocale().localeIdentifier )
        nowDate.dateFormat = format
        // "YYYY.MM.dd HH:mm a"
        
        let doulbeToString = nowDate.stringFromDate(temp)
        return doulbeToString
    }
    
    func doubleToRoundUP(count : Double) -> Double {
        
        let numberOfPlacse = count
        
        let multiplier = pow(10.0, numberOfPlacse)
        let rounded = round(self * multiplier) / multiplier
        return rounded
    }

    
}

extension CGFloat {
    init?(_ str: String) {
        guard let float = Float(str) else { return nil }
        self = CGFloat(float)
    }
}

extension String {
    var floatValue: Float {
        return (self as NSString).floatValue
    }
}

