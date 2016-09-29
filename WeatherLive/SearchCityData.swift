//
//  SearchCityData.swift
//  WeatherLive
//
//  Created by Junghoon on 2016. 9. 29..
//  Copyright © 2016년 Junghoon. All rights reserved.
//

import Foundation

class SearchCityData {
    
    var _cityName : String!
    var _countryName : String!
    var _lon : Double!
    var _lat : Double!
    
    
    var cityName: String {
        if _cityName == nil {
            return ""
        }
        return _cityName
    }
    
    var countryName: String {
        if _countryName == nil {
            return ""
        }
        return _countryName
    }
    
    var lon: Double {
        if _lon == nil {
            return 0.0
        }
        return _lon
    }
    var lat: Double {
        if _lat == nil {
            return 0.0
        }
        return _lat
    }




    init(searchCity : Dictionary<String, AnyObject>) {
        
        self._cityName = searchCity["name"] as? String
        
        if let sys = searchCity["sys"] as? Dictionary<String, AnyObject> {
            if let country = sys["country"] as? String {
                self._countryName = country
            }
        }
        if let coord = searchCity["coord"] as? Dictionary<String, AnyObject> {
            if let lon = coord["lon"] as? Double {
                self._lon = lon
            }
            if let lat = coord["lat"] as? Double {
                self._lat = lat
            }
        }
    }
    
}

