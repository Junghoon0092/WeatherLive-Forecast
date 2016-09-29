//
//  HourlyWeatherData.swift
//  WeatherLive
//
//  Created by Junghoon on 2016. 9. 23..
//  Copyright © 2016년 Junghoon. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

class HourlyWeatherData {
    
    
    var _forecastDay : Double!
    var _forecastIcon: String!
    var _forecastTemperature: Double!
    var _forecastStatus: String!
    var _forecastClouds: Double!
    var _forecastHumidity: Double!

    var forecastDay: Double {
        if _forecastDay == nil {
            _forecastDay = 0.0
        }
        return _forecastDay
    }
    
    var forecastIcon: String {
        if _forecastIcon == nil {
            return ""
        }
        
        return _forecastIcon
    }
    
    
    var forecastTemperature: String {
        if _forecastTemperature == nil {
            return ""
        }
        return " \("\(_forecastTemperature.doubleToRoundUP(1))".split(".")[0])˚"
    }
    
    var forecastStatus: String {
        if _forecastStatus == nil {
            return ""
        }
        return _forecastStatus
    }
    
    var forecastClouds: String {
        if _forecastClouds == nil {
            return ""
        }
        return "Clouds : \("\(_forecastClouds.doubleToRoundUP(1))".split(".")[0]) %"
    }
    
    var forecastHumidity: String {
        if _forecastHumidity == nil {
            return ""
        }
        return "Humidity : \("\(_forecastHumidity.doubleToRoundUP(1))".split(".")[0]) %"
    }

    
    
    init(forecastWeatherData : Dictionary<String, AnyObject>) {

        if let dayAndTime = forecastWeatherData["dt"] as? Double {
            self._forecastDay = dayAndTime
        }
        
        if let temp = forecastWeatherData["main"] as? Dictionary<String, AnyObject> {
            if let currentTemp = temp["temp"] as? Double {
                self._forecastTemperature = currentTemp
            }
            if let humidity = temp["humidity"] as? Double {
                self._forecastHumidity = humidity
            }
        }
        if let clouds = forecastWeatherData["clouds"] as? Dictionary<String, AnyObject> {
            if let all = clouds["all"] as? Double {
                self._forecastClouds = all
            }
        }
        if let weatherMain = forecastWeatherData["weather"] as? [Dictionary<String, AnyObject>] {
            if let weatherIcon = weatherMain[0]["main"] as? String {
                self._forecastIcon = weatherIcon
            }
        }
        
    }
    

    
        
    
}

