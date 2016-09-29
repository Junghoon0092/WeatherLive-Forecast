//
//  HourlyTableViewCell.swift
//  WeatherLive
//
//  Created by Junghoon on 2016. 9. 5..
//  Copyright © 2016년 Junghoon. All rights reserved.
//

import UIKit

class HourlyTableViewCell: UITableViewCell {
    
    @IBOutlet weak var forecastDateAndWeekLabel: UILabel!
    @IBOutlet weak var forecastTimeLabel: UILabel!
    
    @IBOutlet weak var forecastIcon: UIImageView!
    
    @IBOutlet weak var forecastTempLabel: UILabel!
    @IBOutlet weak var forecastStatusLabel: UILabel!
    
    @IBOutlet weak var forecastHiTempLabel: UILabel!
    @IBOutlet weak var forecastLoTempLabel: UILabel!
    
    var currentWeatherData = CurrentWeatherData()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func configureCell(forecastWeather: HourlyWeatherData) {
        
        forecastDateAndWeekLabel.text = "\(forecastWeather.forecastDay.unixTimeToString("MM/dd(E)"))"
        forecastTimeLabel.text = "\(forecastWeather.forecastDay.unixTimeToString("HH : mm"))"
        forecastIcon.image = UIImage(named: currentWeatherData.weatherIcon(forecastWeather.forecastIcon))
        forecastTempLabel.text = forecastWeather.forecastTemperature
        forecastStatusLabel.text = forecastWeather.forecastIcon
        forecastHiTempLabel.text = forecastWeather.forecastClouds
        forecastLoTempLabel.text = forecastWeather.forecastHumidity

    }
    

}
