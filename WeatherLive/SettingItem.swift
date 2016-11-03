//
//  SettingItem.swift
//  WeatherLive
//
//  Created by Junghoon on 2016. 11. 3..
//  Copyright © 2016년 Junghoon. All rights reserved.
//


import Foundation

class SettingItem {
    var id : Int64!
    var tempCheck : String!

    
    
    init (id : Int64, tempCheck : String ) {
        self.id = id
        self.tempCheck = tempCheck
    }
    
    func getId() -> Int64 {
        return id!
    }
    func getTempCheck() -> String {
        return tempCheck!
    }

    
}