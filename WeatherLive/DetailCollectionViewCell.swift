//
//  DetailCollectionViewCell.swift
//  WeatherLive
//
//  Created by Junghoon on 2016. 9. 6..
//  Copyright © 2016년 Junghoon. All rights reserved.
//

import UIKit

class TemperatureCell: UICollectionViewCell {

    @IBOutlet weak var titit: UILabel!
    @IBOutlet weak var hiLowTempLabel: UILabel!
}

class WindCell: UICollectionViewCell {
    
    @IBOutlet weak var windSpeedLabel: UILabel!

}

class HumidityCell: UICollectionViewCell {
    
    @IBOutlet weak var humiLabel: UILabel!
    
}
class CloudsCell: UICollectionViewCell {
    
    @IBOutlet weak var cloudsLabel: UILabel!
    
}

class SunriseCell: UICollectionViewCell {
    
    @IBOutlet weak var sunRiseLabel: UILabel!
    
}

class SunsetCell: UICollectionViewCell {
    
    @IBOutlet weak var sunSetLabel: UILabel!
    
}

class Forecast3HCell: UICollectionViewCell {
    
    @IBOutlet weak var for3hourTimeLabel: UILabel!
    @IBOutlet weak var for3hourImage: UIImageView!
    @IBOutlet weak var for3hourTempLabel: UILabel!
    @IBOutlet weak var for3hourWeatherLabel: UILabel!
    
}

class Forecast6HCell: UICollectionViewCell {
    
    @IBOutlet weak var for6hourTimeLabel: UILabel!
    @IBOutlet weak var for6hourImage: UIImageView!
    @IBOutlet weak var for6hourTempLabel: UILabel!
    @IBOutlet weak var for6hourWeatherLabel: UILabel!

}

class Forecast12HCell: UICollectionViewCell {

    @IBOutlet weak var for12hourTimeLabel: UILabel!
    @IBOutlet weak var for12hourImage: UIImageView!
    @IBOutlet weak var for12hourTempLabel: UILabel!
    @IBOutlet weak var for12hourWeatherLabel: UILabel!
    
    
}


