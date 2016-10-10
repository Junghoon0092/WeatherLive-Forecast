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
    
    @IBOutlet weak var contryName: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
