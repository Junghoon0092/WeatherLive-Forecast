


import Foundation
import UIKit
import Alamofire
import SwiftyJSON
import SwiftString


class LocationWeatherData {
    
    var _cityLabel: String!
    var _tempLabel: Double!
    
    var _hiTempLabel: Double!
    var _loTempLabel: Double!
    
    var _todayImage: String?
    var _tomorrowImage: String?
    var _afterTomorrowImage: String?
    
    var _todayTempLabel: Double!
    var _tomorrowTempLabel: Double!
    var _afterTomorrowTempLabel: Double!
    
    var _todayWeekLabel: Double!
    var _tomorrowWeekLabel: Double!
    var _afterTomorrowWeekLabel: Double!
    
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
    

    var hiTempLabel: String {
        if _hiTempLabel == nil {
            return ""
        }
        return "Hi : \("\(_hiTempLabel.doubleToRoundUP(0))".split(".")[0])˚"
    }
    
    var loTempLabel: String {
        if _loTempLabel == nil {
            return ""
        }
        return "Lo : \("\(_loTempLabel.doubleToRoundUP(0))".split(".")[0])˚"
    }
    
    
    var todayTempLabel: String {
        if _todayTempLabel == nil {
            return ""
        }
        return "\("\(_todayTempLabel)".split(".")[0])˚"
    }
    
    var tomorrowTempLabel: String {
        if _tomorrowTempLabel == nil {
            return ""
        }
        return "\("\(_tomorrowTempLabel)".split(".")[0])˚"
    }
    
    var afterTomorrowTempLabel: String {
        if _afterTomorrowTempLabel == nil {
            return ""
        }
        return "\("\(_afterTomorrowTempLabel)".split(".")[0])˚"
    }
    
    var todayImage: String {
        if _todayImage == nil {
            _todayImage = "Rain"
        }
        return _todayImage!
    }
    
    var tomorrowImage: String {
        if _tomorrowImage == nil {
            _tomorrowImage = "Rain"
        }
        return _tomorrowImage!
    }
    
    var afterTomorrowImage: String {
        if _afterTomorrowImage == nil {
            _afterTomorrowImage = "Rain"
        }
        return _afterTomorrowImage!
    }
    
    var todayWeekLabel: String {
        if _todayWeekLabel == nil {
            _todayWeekLabel = 0.0
        }
        return _todayWeekLabel.unixTimeToString("EEEE")
    }
    
    var tomorrowWeekLabel: String {
        if _tomorrowWeekLabel == nil {
            _tomorrowWeekLabel = 0.0
        }
        return _tomorrowWeekLabel.unixTimeToString("EEEE")
    }
    
    var afterTomorrowWeekLabel: String {
        if _afterTomorrowWeekLabel == nil {
            _afterTomorrowWeekLabel = 0.0
        }
        return _afterTomorrowWeekLabel.unixTimeToString("EEEE")
    }
    
    init(cityLabel : String, tempLabel : Double, hiTempLabel : Double, loTempLabel : Double, todayImage : String, tomorrowImage :String, afterTomorrowImage : String, todayTempLabel : Double, tomorrowTempLabel: Double, afterTomorrowTempLabel: Double, todayWeekLabel : Double, tomorrowWeekLabel : Double , afterTomorrowWeekLabel : Double ) {
        
        self._tempLabel = tempLabel
        self._cityLabel = cityLabel
        self._hiTempLabel = hiTempLabel
        self._loTempLabel = loTempLabel
        
        self._todayImage = todayImage
        self._tomorrowImage = tomorrowImage
        self._afterTomorrowImage = afterTomorrowImage
        
        self._todayTempLabel = todayTempLabel
        self._tomorrowTempLabel = tomorrowTempLabel
        self._afterTomorrowTempLabel = afterTomorrowTempLabel
        
        self._todayWeekLabel = todayWeekLabel
        self._tomorrowWeekLabel = tomorrowWeekLabel
        self._afterTomorrowWeekLabel = afterTomorrowWeekLabel
        
    }
    
    class func download ( completed : ((LocationWeatherData) -> Void) ) {
        let url = NSData(contentsOfURL : NSURL(string: LOCATION_CURRENT_URL)!)
        let json = JSON(data: url!)
        let tempLabel = json["list"][0]["temp"]["day"].double!
        let citylabel = "\(json["city"]["name"].string!).\(json["city"]["country"].string!)"
        let hiTempLabel = json["list"][0]["temp"]["max"].double!
        let loTempLabel = json["list"][0]["temp"]["min"].double!
        
        let todayImage = json["list"][0]["weather"][0]["main"].string!
        let tomorrowImage = json["list"][1]["weather"][0]["main"].string!
        let afterTomorrowImage = json["list"][2]["weather"][0]["main"].string!
        
        let todayTempLabel = json["list"][0]["temp"]["day"].double!
        let tomorrowTempLabel = json["list"][1]["temp"]["day"].double!
        let afterTomorrowTempLabel = json["list"][2]["temp"]["day"].double!
        
        let todayWeekLabel = json["list"][0]["dt"].double!
        let tomorrowWeekLabel = json["list"][1]["dt"].double!
        let afterTomorrowWeekLabel = json["list"][2]["dt"].double!
        
        let locationData = LocationWeatherData.init(cityLabel: citylabel, tempLabel: tempLabel, hiTempLabel: hiTempLabel, loTempLabel: loTempLabel, todayImage: todayImage, tomorrowImage: tomorrowImage, afterTomorrowImage: afterTomorrowImage, todayTempLabel: todayTempLabel, tomorrowTempLabel: tomorrowTempLabel, afterTomorrowTempLabel: afterTomorrowTempLabel, todayWeekLabel: todayWeekLabel, tomorrowWeekLabel: tomorrowWeekLabel, afterTomorrowWeekLabel: afterTomorrowWeekLabel)
        
        completed(locationData)
    }
    
//    init(locationWeatherData : [Dictionary<String, AnyObject>]) {
//        
//        for obj in 0...2 {
//            
//            if obj == 0 {
//                
//                self._todayWeekLabel = locationWeatherData[obj]["dt"] as? Double
//                
//                if let temp = locationWeatherData[obj]["temp"] as? Dictionary<String, AnyObject> {
//                    self._tempLabel = temp["day"] as? Double
//                    self._hiTempLabel = temp["max"] as? Double
//                    self._loTempLabel = temp["min"] as? Double
//                    self._todayTempLabel = self._tempLabel
//                }
//                if let weather = locationWeatherData[obj]["weather"] as? [Dictionary<String, AnyObject>] {
//                    self._todayImage = weather[0]["main"] as? String
//                }
//            }
//            if obj == 1 {
//                
//                self._tomorrowWeekLabel = locationWeatherData[obj]["dt"] as? Double
//                
//                if let weather = locationWeatherData[obj]["weather"] as? [Dictionary<String, AnyObject>] {
//                    self._tomorrowImage = weather[0]["main"] as? String
//                    self._afterTomorrowImage = weather[0]["main"] as? String
//                }
//                
//                if let temp = locationWeatherData[obj]["temp"] as? Dictionary<String, AnyObject> {
//                    self._tomorrowTempLabel = temp["day"] as? Double
//                }
//            }
//            
//            if obj == 2 {
//                
//                self._afterTomorrowWeekLabel = locationWeatherData[obj]["dt"] as? Double
//                
//                if let weather = locationWeatherData[obj]["weather"] as? [Dictionary<String, AnyObject>] {
//                    self._afterTomorrowImage = weather[0]["main"] as? String
//                    
//                    if let temp = locationWeatherData[obj]["temp"] as? Dictionary<String, AnyObject> {
//                        self._afterTomorrowTempLabel = temp["day"] as? Double
//                    }
//                }
//                
//            }
//        }
//    }
    
    


    func loactionWeatherDataJSON(completed: DownloadComplete) {
        let url = NSData(contentsOfURL : NSURL(string: LOCATION_CURRENT_URL)!)
        let json = JSON(data: url!)
        self._cityLabel = "\(json["city"]["name"].string!).\(json["city"]["country"].string!)"
        self._tempLabel = json["list"][0]["temp"]["day"].double!
        self._hiTempLabel = json["list"][0]["temp"]["max"].double!
        self._loTempLabel = json["list"][0]["temp"]["min"].double!
        
        self._todayImage = json["list"][0]["weather"][0]["main"].string!
        self._tomorrowImage = json["list"][1]["weather"][0]["main"].string!
        self._afterTomorrowImage = json["list"][2]["weather"][0]["main"].string!
        
        self._todayTempLabel = json["list"][0]["temp"]["day"].double!
        self._tomorrowTempLabel = json["list"][1]["temp"]["day"].double!
        self._afterTomorrowTempLabel = json["list"][2]["temp"]["day"].double!
        
        self._todayWeekLabel = json["list"][0]["dt"].double!
        self._tomorrowWeekLabel = json["list"][1]["dt"].double!
        self._afterTomorrowWeekLabel = json["list"][2]["dt"].double!
        
        
        
        completed()
    }

    
}


