//
//  DailyWeatherData.swift
//  WeatherLive
//
//  Created by Junghoon on 2016. 9. 29..
//  Copyright © 2016년 Junghoon. All rights reserved.
//

import Foundation
import UIKit

class DailyWeatherData {

    var _dailyDateLabel: Double!
    var _dailyWeatherIcon: String!
    var _dailyTempLabel: Double!
    var _dailyStatusLabel: String!
    var _dailyCloudsLabel: Double!
    var _dailyHumidityLabel: Double!

    var dailyDateLabel: Double {
        if _dailyDateLabel == nil {
            _dailyDateLabel = 0.0
        }
        return _dailyDateLabel
    }
    var dailyWeatherIcon: String {
        if _dailyWeatherIcon == nil {
            return ""
        }
        return _dailyWeatherIcon
    }
    
    var dailyTempLabel: String {
        if _dailyTempLabel == nil {
            return ""
        }
        return " \("\(_dailyTempLabel.doubleToRoundUP(1))".split(".")[0])˚"
    }
    var dailyStatusLabel: String {
        if _dailyStatusLabel == nil {
            return ""
        }
        return _dailyStatusLabel
    }
    var dailyCloudsLabel: String {
        if _dailyCloudsLabel == nil {
            return ""
        }
        return "Clouds : \("\(_dailyCloudsLabel.doubleToRoundUP(1))".split(".")[0]) %"
    }
    
    var dailyHumidityLabel: String {
        if _dailyHumidityLabel == nil {
            return ""
        }
        return "Humidity : \("\(_dailyHumidityLabel.doubleToRoundUP(1))".split(".")[0]) %"
    }
    
    init(dailyWeatherData : Dictionary<String, AnyObject>) {
        
        self._dailyDateLabel = dailyWeatherData["dt"] as? Double
        self._dailyHumidityLabel = dailyWeatherData["humidity"] as? Double
        self._dailyCloudsLabel = dailyWeatherData["clouds"] as? Double
      
        if let weatherMain = dailyWeatherData["weather"] as? [Dictionary<String, AnyObject>] {
            if let weatherIcon = weatherMain[0]["main"] as? String {
                self._dailyWeatherIcon = weatherIcon
            }
        }
        
        if let temp = dailyWeatherData["temp"] as? Dictionary<String, AnyObject> {
            if let currentTemp = temp["day"] as? Double {
                self._dailyTempLabel = currentTemp
            }
        }
      
    }

    
    
}