//
//  FeedItemModel.swift
//  RSS News Reader
//
//  Created by Junghoon on 2016. 8. 11..
//  Copyright © 2016년 Junghoon. All rights reserved.
//

import Foundation

class LocationItem {
    var id : Int64!
    var latitude : String!
    var longitude : String!
    var cityName : String!
    
    
    init (id : Int64, latitude : String, longitude : String, cityName : String ) {
        self.id = id
        self.latitude = latitude
        self.longitude = longitude
        self.cityName = cityName
    }
    
    func getId() -> Int64 {
        return id!
    }
    func getLatitude() -> String {
        return latitude!
    }
    func getLongitude() -> String {
        return longitude!
    }
    func getCityName() -> String {
        return cityName!
    }

}