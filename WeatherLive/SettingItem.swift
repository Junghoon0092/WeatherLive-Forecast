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
    var tempCheck : Int64!

    init (id : Int64, tempCheck : Int64 ) {
        self.id = id
        self.tempCheck = tempCheck
    }
    
    func getId() -> Int64 {
        return id!
    }
    func getTempCheck() -> Int64 {
        return tempCheck!
    }

    
}