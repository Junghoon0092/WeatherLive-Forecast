//
//  Constants.swift
//  WeatherLive
//
//  Created by Junghoon on 2016. 9. 6..
//  Copyright © 2016년 Junghoon. All rights reserved.
//

import Foundation


let CURRENT_BASE = "http://api.openweathermap.org/data/2.5/weather?"
let FORECAST_5DAY_BASE = "http://api.openweathermap.org/data/2.5/forecast?"
let FORECAST_16DAY_BASE = "http://api.openweathermap.org/data/2.5/forecast/daily?"

let API_KEY = "42a1771a0b787bf12e734ada0cfc80cb"

typealias DownloadComplete = () -> ()

let LOCATION_CURRENT_URL = "\(FORECAST_16DAY_BASE)lat=\(SQLiteDataBase.sharedInstance.latitude!)&lon=\(SQLiteDataBase.sharedInstance.longitude!)&units=metric&appid=\(API_KEY)"
//
//let CURRENT_URL = "\(CURRENT_BASE)lat=\(Location.sharedInstance.latitude!)&lon=\(Location.sharedInstance.longitude!)&units=metric&appid=\(API_KEY)"
//let FORECAST_5DAY_URL = "\(FORECAST_5DAY_BASE)lat=\(Location.sharedInstance.latitude!)&lon=\(Location.sharedInstance.longitude!)&units=metric&appid=\(API_KEY)"
//let FORECAST_16DAY_URL = "\(FORECAST_16DAY_BASE)lat=\(Location.sharedInstance.latitude!)&lon=\(Location.sharedInstance.longitude!)&units=metric&cnt=10&appid=\(API_KEY)"

//let CURRENT_URL = "\(CURRENT_BASE)lat=37.15&lon=127.07&units=metric&appid=\(API_KEY)"
//let FORECAST_5DAY_URL = "\(FORECAST_5DAY_BASE)lat=\(Location.sharedInstance.latitude!)&lon=\(Location.sharedInstance.longitude!)&appid=\(API_KEY)"
//let FORECAST_16DAY_URL = "\(FORECAST_16DAY_BASE)lat=\(Location.sharedInstance.latitude!)&lon=\(Location.sharedInstance.longitude!)&appid=\(API_KEY)"
