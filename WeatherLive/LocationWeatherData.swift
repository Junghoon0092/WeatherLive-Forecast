


import Foundation
import UIKit
import Alamofire
import SwiftyJSON
import SwiftString


class LocationWeatherData {
    
    var _cityLabel: String!
    var _tempLabel: String!
    
    var _hiTempLabel: String!
    var _loTempLabel: String!
    
    var _todayImage: String!
    var _tomorrowImage: String!
    var _afterTomorrowImage: String!
    
    var _todayTempLabel: String!
    var _tomorrowTempLabel: String!
    var _afterTomorrowTempLabel: String!
    
    var _todayWeekLabel: Double!
    var _tomorrowWeekLabel: Double!
    var _afterTomorrowWeekLabel: Double!
 
  
    var funcCollection = FuncCollection()
    
    
    
    var cityLabel: String {
        if _cityLabel == nil {
            _cityLabel = ""
        }
        return _cityLabel
    }
    
    var tempLabel: String {
        if _tempLabel == nil {
            return ""
        }
        switch _tempLabel.characters.count {
        case 6 :
            _tempLabel = "\(_tempLabel.substring(0, length: 3))˚"
        case 5 :
            _tempLabel = "\(_tempLabel.substring(0, length: 2))˚"
        case 4 :
            _tempLabel = "\(_tempLabel.substring(0, length: 1))˚"
        default:
            _tempLabel = "\(_tempLabel)˚"
        }
        return "\(_tempLabel)"
    }

    var hiTempLabel: String {
        if _hiTempLabel == nil {
            return ""
        }
        switch _hiTempLabel.characters.count {
        case 5 :
            _hiTempLabel = "\(_hiTempLabel.substring(0, length: 2))˚"
        case 4 :
            _hiTempLabel = "\(_hiTempLabel.substring(0, length: 1))˚"
        default:
            _hiTempLabel = "\(_hiTempLabel)˚"
        }
        return "Hi : \(_hiTempLabel)"
    }
    
    var loTempLabel: String {
        if _loTempLabel == nil {
            return ""
        }
        switch _loTempLabel.characters.count {
        case 5 :
            _loTempLabel = "\(_loTempLabel.substring(0, length: 2))˚"
        case 4 :
            _loTempLabel = "\(_loTempLabel.substring(0, length: 1))˚"
        default:
            _loTempLabel = "\(_loTempLabel)˚"
        }
        return "Lo : \(_loTempLabel)"
    }
    
    
    var todayImage: String {
        if _todayImage == nil {
            _todayImage = ""
        }
        return weatherIcon(_todayImage)
    }
    
    var tomorrowImage: String {
        if _tomorrowImage == nil {
            _tomorrowImage = ""
        }
        return weatherIcon(_tomorrowImage)
    }
    
    var afterTomorrowImage: String {
        if _afterTomorrowImage == nil {
            _afterTomorrowImage = ""
        }
        return weatherIcon(_tomorrowImage)
    }
    

    
    var todayWeekLabel: String {
        if _todayWeekLabel == nil {
            _todayWeekLabel = 0.0
        }
        return self.funcCollection.unixTimeToString(_todayWeekLabel, format: "EEEE")
    }
    
    var tomorrowWeekLabel: String {
        if _tomorrowWeekLabel == nil {
            _tomorrowWeekLabel = 0.0
        }
        return self.funcCollection.unixTimeToString(_tomorrowWeekLabel, format: "EEEE")    }
    
    var afterTomorrowWeekLabel: String {
        if _afterTomorrowWeekLabel == nil {
            _afterTomorrowWeekLabel = 0.0
        }
        return self.funcCollection.unixTimeToString(_afterTomorrowWeekLabel, format: "EEEE")
    }
    
    
    func weatherIcon(weather : String) -> String {
        switch weather {
        case "Rain":
            return "raining"
        case "Thunderstorm":
            return "bolt"
        case "Drizzle":
            return "drizzle"
        case "Snow":
            return "snowing"
        case "Atmosphere":
            return "calm"
        case "Clear":
            return "sunny"
        case "Clouds":
            return "clouds"
        case "Extreme":
            return "tornado"
        case "Additional":
            return "wind-2"
        default:
            return ""
        }
    }

    
  
    func loactionWeatherDataJSON(completed: DownloadComplete) {
        let url = NSData(contentsOfURL : NSURL(string: LOCATION_CURRENT_URL)!)
        let json = JSON(data: url!)
        self._cityLabel = "\(json["city"]["name"].string!).\(json["city"]["country"].string!)"
        print("\(self._cityLabel)")
        self._tempLabel = "\(json["list"][0]["temp"]["day"].double!)"
        self._hiTempLabel = "\(json["list"][0]["temp"]["max"].double!)"
        self._loTempLabel = "\(json["list"][0]["temp"]["min"].double!)"
        
        self._todayImage = json["list"][0]["weather"][0]["main"].string!
        self._tomorrowImage = json["list"][1]["weather"][0]["main"].string!
        self._afterTomorrowImage = json["list"][2]["weather"][0]["main"].string!
        
        self._todayTempLabel = "\(json["list"][0]["temp"]["day"].double!)"
        self._tomorrowTempLabel = "\(json["list"][1]["temp"]["day"].double!)"
        self._afterTomorrowTempLabel = "\(json["list"][2]["temp"]["day"].double!)"
        
        self._todayWeekLabel = json["list"][0]["dt"].double!
        self._tomorrowWeekLabel = json["list"][1]["dt"].double!
        self._afterTomorrowWeekLabel = json["list"][2]["dt"].double!
        completed()
    }
    
//    func downloadSwiftyJSONDataForcasting() {
//        let url = NSData(contentsOfURL : NSURL(string: FORECAST_5DAY_URL)!)
//        let json = JSON(data: url!)
//        self._for3hourTimeLabel = json["list"][0]["dt"].double!
//        self._for3hourTempLabel = "\(json["list"][0]["main"]["temp"].double!)"
//        self._for3hourWeatherLabel = json["list"][0]["weather"][0]["main"].string
//        self._for3hourImage = json["list"][0]["weather"][0]["main"].string
//        
//        self._for6hourTimeLabel = json["list"][2]["dt"].double!
//        self._for6hourTempLabel = "\(json["list"][2]["main"]["temp"].double!)"
//        self._for6hourWeatherLabel = json["list"][2]["weather"][0]["main"].string
//        self._for6hourImage = json["list"][2]["weather"][0]["main"].string
//        
//        self._for12hourTimeLabel = json["list"][4]["dt"].double!
//        self._for12hourTempLabel = "\(json["list"][4]["main"]["temp"].double!)"
//        self._for12hourWeatherLabel = json["list"][4]["weather"][0]["main"].string
//        self._for12hourImage = json["list"][4]["weather"][0]["main"].string
//
//    }
    
}

















