


import Foundation
import UIKit
import Alamofire
import SwiftyJSON
import SwiftString


class CurrentWeatherData {
    
    var _lastUpdate : String!
    var _temperature: String!
    var _hiTemperature: String!
    var _loTemperature: String!
    var _windSpeed: String!
    var _windDirection: String!
    var _humidity: String!
    var _clouds: String!
    var _sunrise: Double!
    var _sunset: Double!
    var _for3hourTimeLabel : Double!
    var _for3hourImage : String!
    var _for3hourTempLabel : String!
    var _for3hourWeatherLabel : String!
    
    var _for6hourTimeLabel : Double!
    var _for6hourImage : String!
    var _for6hourTempLabel : String!
    var _for6hourWeatherLabel : String!
    
    var _for12hourTimeLabel : Double!
    var _for12hourImage : String!
    var _for12hourTempLabel : String!
    var _for12hourWeatherLabel : String!
    
    var funcCollection = FuncCollection()
    
    
    var lastUpdate: String {
        if _lastUpdate == nil {
            _lastUpdate = ""
        }
        return _lastUpdate
    }
    
    var temperature: String {
        if _temperature == nil {
            return ""
        }
        switch _temperature.characters.count {
        case 6 :
            _temperature = "\(_temperature.substring(0, length: 3))˚"
        case 5 :
            _temperature = "\(_temperature.substring(0, length: 2))˚"
        case 4 :
            _temperature = "\(_temperature.substring(0, length: 1))˚"
        default:
            _temperature = "\(_temperature)˚"
        }
        return "\(_temperature)"
    }
    
    
    var hiTemperature: String {
        if _hiTemperature == nil {
            _hiTemperature = ""
        }
        switch _hiTemperature.characters.count {
        case 5 :
            _hiTemperature = "\(_hiTemperature.substring(0, length: 2))˚"
        case 4 :
            _hiTemperature = "\(_hiTemperature.substring(0, length: 1))˚"
        default:
            _hiTemperature = "\(_hiTemperature)˚"
        }
        return _hiTemperature
    }
    var loTemperature: String {
        if _loTemperature == nil {
            _loTemperature = ""
        }
        switch _loTemperature.characters.count {
        case 5 :
            _loTemperature = "\(_loTemperature.substring(0, length: 2))˚"
        case 4 :
            _loTemperature = "\(_loTemperature.substring(0, length: 1))˚"
        default:
            _loTemperature = "\(_loTemperature)˚"
        }
        return _loTemperature
    }
    
    var windSpeed: String {
        if _windSpeed == nil {
            _windSpeed = ""
        }
        if _windSpeed.characters.count >= 4 {
            _windSpeed = "\(_windSpeed.substring(0, length: 2))0"
        } else {
            _windSpeed = "\(_windSpeed.substring(0, length: 1)).0"
        }
        
        return _windSpeed
    }
    
    var windDirection: String {
        if _windDirection == nil {
            _windDirection = ""
        }
        return _windDirection
    }
    
    var humidity: String {
        if _humidity == nil {
            _humidity = ""
        }
        if _humidity.characters.count >= 5 {
            _humidity = _humidity.substring(0, length: 3)
        } else {
            _humidity = _humidity.substring(0, length: 2)
        }
        return "\(_humidity) %"
    }
    
    var clouds: String {
        if _clouds == nil {
            _clouds = ""
        }
        return "\(_clouds) %"
    }
    
    var sunrise: String {
        if _sunrise == nil {
            _sunrise = 0.0
        }
        return self.funcCollection.unixTimeToString(_sunrise, format: "HH:mm")
    }
    
    var sunset: String {
        if _sunset == nil {
            _sunset = 0.0
        }
        return "\(self.funcCollection.unixTimeToString(_sunset, format: "HH:mm"))"
    }
    
    var for3hourTimeLabel: String {
        if _for3hourTimeLabel == nil {
            _for3hourTimeLabel = 0.0
        }
        return "\(self.funcCollection.unixTimeToString(_for3hourTimeLabel, format: "MM/dd HH:mm"))"
    }
    var for3hourTempLabel: String {
        if _for3hourTempLabel == nil {
            _for3hourTempLabel = ""
        }
        _for3hourTempLabel = "\(_for3hourTempLabel.substring(0, length: 2))˚"
        return _for3hourTempLabel
    }
    var for3hourWeatherLabel: String {
        if _for3hourWeatherLabel == nil {
            _for3hourWeatherLabel = ""
        }
        return _for3hourWeatherLabel
    }
    
    var for3hourImage: String {
        if _for3hourImage == nil {
            _for3hourImage = ""
        }
        return weatherIcon(_for3hourImage)
    }
    
    
    
    
    var for6hourTimeLabel: String {
        if _for6hourTimeLabel == nil {
            _for6hourTimeLabel = 0.0
        }
        return "\(self.funcCollection.unixTimeToString(_for6hourTimeLabel, format: "MM/dd HH:mm"))"
    }
    var for6hourTempLabel: String {
        if _for6hourTempLabel == nil {
            _for6hourTempLabel = ""
        }
        _for6hourTempLabel = "\(_for6hourTempLabel.substring(0, length: 2))˚"
        return _for6hourTempLabel
    }
    var for6hourWeatherLabel: String {
        if _for6hourWeatherLabel == nil {
            _for6hourWeatherLabel = ""
        }
        return _for6hourWeatherLabel
    }
    
    var for6hourImage: String {
        if _for6hourImage == nil {
            _for6hourImage = ""
        }
        return weatherIcon(_for6hourImage)
    }
    
    
    
    // 12시간 후 예상
    var for12hourTimeLabel: String {
        if _for12hourTimeLabel == nil {
            _for12hourTimeLabel = 0.0
        }
        return "\(self.funcCollection.unixTimeToString(_for12hourTimeLabel, format: "MM/dd HH:mm"))"
    }
    var for12hourTempLabel: String {
        if _for12hourTempLabel == nil {
            _for12hourTempLabel = ""
        }
        _for12hourTempLabel = "\(_for12hourTempLabel.substring(0, length: 2))˚"
        return _for12hourTempLabel
    }
    var for12hourWeatherLabel: String {
        if _for12hourWeatherLabel == nil {
            _for12hourWeatherLabel = ""
        }
        return _for12hourWeatherLabel
    }
    
    var for12hourImage: String {
        if _for12hourImage == nil {
            _for12hourImage = ""
        }
        return weatherIcon(_for12hourImage)
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
    
    //    func downloadCurrentData() {
    //
    //        let url = NSURL(string: CURRENT_URL)!
    //        Alamofire.request(.GET, url).validate().responseJSON { response in
    //            let result = response.result
    //            print(response)
    //            if let dict = result.value as? Dictionary<String, AnyObject> {
    //                print(dict)
    //                if let main = dict["main"] as? Dictionary<String, AnyObject> {
    //                    if let currentTemp = main["temp"] as? Double {
    //                        self._temperature = "\(currentTemp)"
    //                        print(self._temperature)
    //
    //                    }
    //
    //                }
    //       v     }
    //
    //        }
    //
    //    }
    
    func downloadSwiftyJSONData() {
        let url = NSData(contentsOfURL : NSURL(string: CURRENT_URL)!)
        let json = JSON(data: url!)
        self._temperature = "\(json["main"]["temp"].double!)"
        self._windSpeed = "\(json["wind"]["speed"].double!)"
        self._humidity = "\(json["main"]["humidity"].double!)"
        self._hiTemperature = "\(json["main"]["temp_max"].double!)"
        self._loTemperature = "\(json["main"]["temp_min"].double!)"
        self._clouds = "\(json["clouds"]["all"].int!)"
        self._sunrise = json["sys"]["sunrise"].double!
        self._sunset = json["sys"]["sunset"].double!
    }
    
    func downloadSwiftyJSONDataForcasting() {
        let url = NSData(contentsOfURL : NSURL(string: FORECAST_5DAY_URL)!)
        let json = JSON(data: url!)
        self._for3hourTimeLabel = json["list"][0]["dt"].double!
        self._for3hourTempLabel = "\(json["list"][0]["main"]["temp"].double!)"
        self._for3hourWeatherLabel = json["list"][0]["weather"][0]["main"].string
        self._for3hourImage = json["list"][0]["weather"][0]["main"].string
        
        self._for6hourTimeLabel = json["list"][2]["dt"].double!
        self._for6hourTempLabel = "\(json["list"][2]["main"]["temp"].double!)"
        self._for6hourWeatherLabel = json["list"][2]["weather"][0]["main"].string
        self._for6hourImage = json["list"][2]["weather"][0]["main"].string
        
        self._for12hourTimeLabel = json["list"][4]["dt"].double!
        self._for12hourTempLabel = "\(json["list"][4]["main"]["temp"].double!)"
        self._for12hourWeatherLabel = json["list"][4]["weather"][0]["main"].string
        self._for12hourImage = json["list"][4]["weather"][0]["main"].string
        
    }
    
}

















