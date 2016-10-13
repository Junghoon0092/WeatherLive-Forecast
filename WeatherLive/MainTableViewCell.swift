//
//  MainTableViewCell.swift
//  WeatherLive
//
//  Created by Junghoon on 2016. 9. 5..
//  Copyright © 2016년 Junghoon. All rights reserved.
//

import UIKit

class MainTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    
    @IBOutlet weak var hiTempLabel: UILabel!
    @IBOutlet weak var loTempLabel: UILabel!
    
    @IBOutlet weak var todayImage: UIImageView!
    @IBOutlet weak var tommorwImage: UIImageView!
    @IBOutlet weak var aftertommorwImage: UIImageView!
    
    @IBOutlet weak var todayTempLabel: UILabel!
    @IBOutlet weak var tommorwTempLabel: UILabel!
    @IBOutlet weak var afterTommorwLabel: UILabel!
    
    
    @IBOutlet weak var todayWeekLabel: UILabel!
    @IBOutlet weak var tommorwWeekLabel: UILabel!
    @IBOutlet weak var afterTommorwWeekLabel: UILabel!
    
    var currentWeatherData = CurrentWeatherData()
    var location : LocationWeatherData!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

}

class ContryViewCell: UITableViewCell {
    
    @IBOutlet weak var contryCityName: UILabel!
    @IBOutlet weak var contryTempLabel: UILabel!
    
    @IBOutlet weak var contryHiTempLabel: UILabel!
    @IBOutlet weak var contryLoTempLabel: UILabel!
    
    @IBOutlet weak var contryTodayImage: UIImageView!
    @IBOutlet weak var contryTommorwImage: UIImageView!
    @IBOutlet weak var contryAftertommorwImage: UIImageView!
    
    @IBOutlet weak var contryTodayTempLabel: UILabel!
    @IBOutlet weak var contryTommorwTempLabel: UILabel!
    @IBOutlet weak var contryAfterTommorwLabel: UILabel!
    
    @IBOutlet weak var contryTodayWeekLabel: UILabel!
    @IBOutlet weak var contryTommorwWeekLabel: UILabel!
    @IBOutlet weak var contryAfterTommorwWeekLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
