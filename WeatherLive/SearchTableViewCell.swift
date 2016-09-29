//
//  SearchTableViewCell.swift
//  WeatherLive
//
//  Created by Junghoon on 2016. 9. 29..
//  Copyright © 2016년 Junghoon. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    
    @IBOutlet weak var namelabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(searchCity: SearchCityData) {
        
        namelabel.text = "\(searchCity.cityName) \(searchCity.countryName)"
    
    }

}
