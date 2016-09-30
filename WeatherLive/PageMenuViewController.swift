//
//  PageMenuViewController.swift
//  WeatherLive
//
//  Created by Junghoon on 2016. 9. 22..
//  Copyright © 2016년 Junghoon. All rights reserved.
//

import UIKit

class PageMenuViewController: UIViewController {

    @IBOutlet weak var swiftPageVIew: SwiftPages!
    var locationWeatherData = LocationWeatherData()
    var titleLabel : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        self.navigationItem.title = titleLabel
        
        let VCIDs = ["DetailCollection", "Hourly", "Daily"]
        let buttonTitles = ["Detail", "Hourly", "Daily"]
        automaticallyAdjustsScrollViewInsets = true
 
        swiftPageVIew.setOriginY(0.0)

        swiftPageVIew.enableAeroEffectInTopBar(false)
        swiftPageVIew.setButtonsTextColor(UIColor.blackColor())
        swiftPageVIew.setAnimatedBarColor(UIColor.orangeColor())
        swiftPageVIew.setAnimatedBarHeight(3)
        swiftPageVIew.setTopBarHeight(40)
        swiftPageVIew.initializeWithVCIDsArrayAndButtonTitlesArray(VCIDs, buttonTitlesArray: buttonTitles)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
