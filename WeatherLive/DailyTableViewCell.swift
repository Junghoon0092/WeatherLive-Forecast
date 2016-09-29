//
//  DailyTableViewCell.swift
//  WeatherLive
//
//  Created by Junghoon on 2016. 9. 5..
//  Copyright © 2016년 Junghoon. All rights reserved.
//

import UIKit

class DailyTableViewCell: UITableViewCell {
    
    @IBOutlet weak var dailyDateLabel: UILabel!
    @IBOutlet weak var dailyWeekLabel: UILabel!
    
    @IBOutlet weak var dailyWeatherIcon: UIImageView!
    
    @IBOutlet weak var dailyTempLabel: UILabel!
    @IBOutlet weak var dailyStatusLabel: UILabel!
    
    @IBOutlet weak var dailyCloudsLabel: UILabel!
    @IBOutlet weak var dailyHumidityLabel: UILabel!
    
    var currentWeatherData = CurrentWeatherData()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(dailyForecoastWeahter: DailyWeatherData) {
        
        dailyDateLabel.text = "\(dailyForecoastWeahter.dailyDateLabel.unixTimeToString("MM/dd"))"
        dailyWeekLabel.text = "\(dailyForecoastWeahter.dailyDateLabel.unixTimeToString("EEEE"))"
        dailyWeatherIcon.image = UIImage(named: currentWeatherData.weatherIcon(dailyForecoastWeahter.dailyWeatherIcon))
        dailyTempLabel.text = dailyForecoastWeahter.dailyTempLabel
        dailyStatusLabel.text = dailyForecoastWeahter.dailyWeatherIcon
        dailyCloudsLabel.text = dailyForecoastWeahter.dailyCloudsLabel
        dailyHumidityLabel.text = dailyForecoastWeahter.dailyHumidityLabel
        
    }

}
