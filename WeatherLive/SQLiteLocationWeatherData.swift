


import Foundation
import UIKit
import Alamofire
import SwiftyJSON
import SwiftString


class SQLiteLocationWeatherData {
    
    var _cityLabel: String!
    var _tempLabel: Double!
//    
//    var _hiTempLabel: Double!
//    var _loTempLabel: Double!
//    
//    var _todayImage: String!
//    var _tomorrowImage: String!
//    var _afterTomorrowImage: String!
//    
//    var _todayTempLabel: Double!
//    var _tomorrowTempLabel: Double!
//    var _afterTomorrowTempLabel: Double!
//    
//    var _todayWeekLabel: Double!
//    var _tomorrowWeekLabel: Double!
//    var _afterTomorrowWeekLabel: Double!
    
    var SQLiteLocationData = [SQLiteLocationWeatherData]()
    
    //    func weatherIcon(weather : String) -> String {
    //        switch weather {
    //        case "Rain":
    //            return "raining"
    //        case "Thunderstorm":
    //            return "bolt"
    //        case "Drizzle":
    //            return "drizzle"
    //        case "Snow":
    //            return "snowing"
    //        case "Atmosphere":
    //            return "calm"
    //        case "Clear":
    //            return "sunny"
    //        case "Clouds":
    //            return "clouds"
    //        case "Extreme":
    //            return "tornado"
    //        case "Additional":
    //            return "wind-2"
    //        default:
    //            return ""
    //        }
    //    }
    
    
    var cityLabel: String {
        if _cityLabel == nil {
            _cityLabel = ""
        }
        return _cityLabel.capitalize()
    }
    
    var tempLabel: String {
        if _tempLabel == nil {
            return ""
        }
        return "\("\(_tempLabel.doubleToRoundUP(1))".split(".")[0])˚"
    }
//
//    
//    var hiTempLabel: String {
//        if _hiTempLabel == nil {
//            return ""
//        }
//        return "Hi : \("\(_hiTempLabel.doubleToRoundUP(0))".split(".")[0])˚"
//    }
//    
//    var loTempLabel: String {
//        if _loTempLabel == nil {
//            return ""
//        }
//        return "Lo : \("\(_loTempLabel.doubleToRoundUP(0))".split(".")[0])˚"
//    }
//    
//    
//    var todayTempLabel: String {
//        if _todayTempLabel == nil {
//            return ""
//        }
//        return "\("\(_todayTempLabel)".split(".")[0])˚"
//    }
//    
//    var tomorrowTempLabel: String {
//        if _tomorrowTempLabel == nil {
//            return ""
//        }
//        return "\("\(_tomorrowTempLabel)".split(".")[0])˚"
//    }
//    
//    var afterTomorrowTempLabel: String {
//        if _afterTomorrowTempLabel == nil {
//            return ""
//        }
//        return "\("\(_afterTomorrowTempLabel)".split(".")[0])˚"
//    }
//    
//    var todayImage: String {
//        if _todayImage == nil {
//            _todayImage = ""
//        }
//        return _todayImage
//    }
//    
//    var tomorrowImage: String {
//        if _tomorrowImage == nil {
//            _tomorrowImage = ""
//        }
//        return _tomorrowImage
//    }
//    
//    var afterTomorrowImage: String {
//        if _afterTomorrowImage == nil {
//            _afterTomorrowImage = ""
//        }
//        return _afterTomorrowImage
//    }
//    
//    var todayWeekLabel: String {
//        if _todayWeekLabel == nil {
//            _todayWeekLabel = 0.0
//        }
//        return _todayWeekLabel.unixTimeToString("EEEE")
//    }
//    
//    var tomorrowWeekLabel: String {
//        if _tomorrowWeekLabel == nil {
//            _tomorrowWeekLabel = 0.0
//        }
//        return _tomorrowWeekLabel.unixTimeToString("EEEE")
//    }
//    
//    var afterTomorrowWeekLabel: String {
//        if _afterTomorrowWeekLabel == nil {
//            _afterTomorrowWeekLabel = 0.0
//        }
//        return _afterTomorrowWeekLabel.unixTimeToString("EEEE")
//    }
    
    init(cityLabel : String, tempLabel : Double) {
        self._cityLabel = cityLabel
        self._tempLabel = tempLabel
    }
    
    
    class func SQLiteDownload (lat : String, lon : String, completed : ((SQLiteLocationWeatherData) -> Void) ) {
        
        print("lat :\(lat), lon : \(lon)")
        let findBaseURL = "\(FORECAST_16DAY_BASE)lat=\(lat)&lon=\(lon)&units=metric&appid=\(API_KEY)"
        let url = NSData(contentsOfURL: NSURL(string: findBaseURL)!)
        let json = JSON(data: url!)
        let citylabel = "\(json["city"]["name"].string!).\(json["city"]["country"].string!)"
        let tempLabel = json["list"][0]["temp"]["day"].double!
        print(citylabel)
        print(tempLabel)
        let dbWeatherData = SQLiteLocationWeatherData.init(cityLabel: citylabel, tempLabel: tempLabel)
        print(dbWeatherData)
       
        completed(dbWeatherData)
        
    }
    


    
    

    
    
}


