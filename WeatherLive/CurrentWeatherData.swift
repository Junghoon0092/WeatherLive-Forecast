


import Foundation
import UIKit
import Alamofire
import SwiftyJSON


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
        switch _temperature.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) {
        case 6 :
            _temperature = _temperature[_temperature.startIndex.advancedBy(0)..._temperature.startIndex.advancedBy(2)]
            _temperature = "\(_temperature)˚"
        case 5 :
            _temperature = _temperature[_temperature.startIndex.advancedBy(0)..._temperature.startIndex.advancedBy(1)]
            _temperature = "\(_temperature)˚"
        case 4 :
            _temperature = _temperature[_temperature.startIndex.advancedBy(0)..._temperature.startIndex.advancedBy(0)]
            _temperature = "\(_temperature)˚"
        default:
            _temperature = "\(_temperature)˚"
        }
        return _temperature
    }

    
    var hiTemperature: String {
        if _hiTemperature == nil {
            _hiTemperature = ""
        }
        switch _hiTemperature.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) {
        case 5 :
            _hiTemperature = _hiTemperature[_hiTemperature.startIndex.advancedBy(0)..._hiTemperature.startIndex.advancedBy(2)]
            _hiTemperature = "\(_hiTemperature)˚"
        case 4 :
            _hiTemperature = _hiTemperature[_hiTemperature.startIndex.advancedBy(0)..._hiTemperature.startIndex.advancedBy(1)]
            _hiTemperature = "\(_hiTemperature)˚"
        default:
            _hiTemperature = "\(_hiTemperature)˚"
        }
        return _hiTemperature
    }
    var loTemperature: String {
        if _loTemperature == nil {
            _loTemperature = ""
        }
        switch _loTemperature.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) {
        case 5 :
            _loTemperature = _loTemperature[_loTemperature.startIndex.advancedBy(0)..._loTemperature.startIndex.advancedBy(2)]
            _loTemperature = "\(_loTemperature)˚"
        case 4 :
            _loTemperature = _loTemperature[_loTemperature.startIndex.advancedBy(0)..._loTemperature.startIndex.advancedBy(1)]
            _loTemperature = "\(_loTemperature)˚"
        default:
            _loTemperature = "\(_loTemperature)˚"
        }
        return _loTemperature
    }
    
    var windSpeed: String {
        if _windSpeed == nil {
            _windSpeed = ""
        }
        if _windSpeed.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) >= 4 {
        _windSpeed = _windSpeed[_windSpeed.startIndex.advancedBy(0)..._windSpeed.startIndex.advancedBy(1)]
        _windSpeed = "\(_windSpeed)"
        } else {
        _windSpeed = _windSpeed[_windSpeed.startIndex.advancedBy(0)..._windSpeed.startIndex.advancedBy(0)]
        _windSpeed = "\(_windSpeed).0"
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
        if _humidity.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) >= 5 {
            _humidity = _humidity[_humidity.startIndex.advancedBy(0)..._humidity.startIndex.advancedBy(2)]
        } else {
            _humidity = _humidity[_humidity.startIndex.advancedBy(0)..._humidity.startIndex.advancedBy(1)]
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
        return "\(self.funcCollection.unixTimeToString(_sunrise, format: "HH:mm"))"
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
        return "\(self.funcCollection.unixTimeToString(_for3hourTimeLabel, format: "HH:mm"))"
    }
    var for3hourTempLabel: String {
        if _for3hourTempLabel == nil {
            _for3hourTempLabel = ""
        }
        return _for3hourTempLabel
    }
    var for3hourWeatherLabel: String {
        if _for3hourWeatherLabel == nil {
            _for3hourWeatherLabel = ""
        }
        return _for3hourWeatherLabel
    }
    
    var forecast12Hour: String {
        if _for3hourWeatherLabel == nil {
            _for3hourWeatherLabel = ""
        }
        return _for3hourWeatherLabel
    }
    
    var for3hourImage: String {
        if _for3hourImage == nil {
            _for3hourImage = ""
        }
        switch _for3hourImage {
        case "light rain":
            return "sunny.png"
        case "few clouds":
            return "snwoimage"
        case "scattered clouds":
            return "snwoimage"
        case "broken clouds":
            return "snwoimage"
        case "shower rain":
            return "snwoimage"
        case "rain":
            return "snwoimage"
        case "thunderstorm":
            return "snwoimage"
        case "snow":
            return "snwoimage"
        case "mist":
            return "snwoimage"
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
        self._for3hourTimeLabel = json["list"][1]["dt"].double!
        self._for3hourTempLabel = "\(json["list"][1]["main"]["temp"].double!)"
        self._for3hourWeatherLabel = json["list"][1]["weather"][0]["main"].string
        self._for3hourImage = json["list"][1]["weather"][0]["description"].string
        print(self._for3hourImage)
    }
    
}

















