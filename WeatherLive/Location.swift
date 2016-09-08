//
//  Location.swift
//  WeatherLive
//
//  Created by Junghoon on 2016. 9. 6..
//  Copyright © 2016년 Junghoon. All rights reserved.
//

import CoreLocation

class Location {
    static var sharedInstance = Location()
    private init() {}
    
    var latitude: Double!
    var longitude: Double!
}
