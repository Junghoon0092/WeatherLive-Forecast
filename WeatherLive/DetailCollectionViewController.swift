//
//  DetailCollectionViewController.swift
//  WeatherLive
//
//  Created by Junghoon on 2016. 9. 5..
//  Copyright © 2016년 Junghoon. All rights reserved.
//

import UIKit
import Firebase

class DetailCollectionViewController: UICollectionViewController ,UICollectionViewDelegateFlowLayout{



    var currentWeatherData = CurrentWeatherData()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.collectionView?.backgroundColor = UIColor.whiteColor()
        
        let sendValue = UIApplication.sharedApplication().delegate as? AppDelegate

        currentWeatherData.downloadSwiftyJSONData((sendValue?.latitude)!, long: (sendValue?.longitude)!)
        currentWeatherData.downloadSwiftyJSONDataForcasting((sendValue?.latitude)!, long: (sendValue?.longitude)!)
        

        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        self.collectionView?.reloadData()
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource
    
    

     override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


     override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 9
    }

     override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        var returnCell = UICollectionViewCell()
        
        switch indexPath.item {
        case 0 :
        
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("TemperatureCell", forIndexPath: indexPath) as! TemperatureCell
            cell.contentView.frame = cell.bounds
            cell.contentView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
            cell.title.text = currentWeatherData.temperature
            cell.hiLowTempLabel.text = "Hi : \(currentWeatherData.hiTemperature)  Lo : \(currentWeatherData.loTemperature)"
            returnCell = cell
        case 1:
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("WindCell", forIndexPath: indexPath) as! WindCell
            cell.contentView.frame = cell.bounds
            cell.contentView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
            cell.windSpeedLabel.text = currentWeatherData.windSpeed
            cell.windDirectLabel.text = currentWeatherData.windDirection
            returnCell = cell
        case 2:
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("HumidityCell", forIndexPath: indexPath) as! HumidityCell
            cell.contentView.frame = cell.bounds
            cell.contentView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
            cell.humiLabel.text = currentWeatherData.humidity
            returnCell = cell
        case 3:
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CloudsCell", forIndexPath: indexPath) as! CloudsCell
            cell.contentView.frame = cell.bounds
            cell.contentView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
            cell.cloudsLabel.text = currentWeatherData.clouds
            returnCell = cell
        case 4:
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("SunriseCell", forIndexPath: indexPath) as! SunriseCell
            cell.contentView.frame = cell.bounds
            cell.contentView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
            cell.sunRiseLabel.text = currentWeatherData.sunrise
            returnCell = cell
        case 5:
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("SunsetCell", forIndexPath: indexPath) as! SunsetCell
            cell.contentView.frame = cell.bounds
            cell.contentView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
            cell.sunSetLabel.text = currentWeatherData.sunset
            returnCell = cell
        case 6:
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Forecast3HCell", forIndexPath: indexPath) as! Forecast3HCell
            cell.contentView.frame = cell.bounds
            cell.contentView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
            cell.for3hourTimeLabel.text = currentWeatherData.for3hourTimeLabel
            cell.for3hourTempLabel.text = currentWeatherData.for3hourTempLabel
            cell.for3hourWeatherLabel.text = currentWeatherData.for3hourWeatherLabel
            cell.for3hourImage.image = UIImage(named: currentWeatherData.for3hourImage)
            returnCell = cell
        case 7:
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Forecast6HCell", forIndexPath: indexPath) as! Forecast6HCell
            cell.contentView.frame = cell.bounds
            cell.contentView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
            cell.for6hourTimeLabel.text = currentWeatherData.for6hourTimeLabel
            cell.for6hourTempLabel.text = currentWeatherData.for6hourTempLabel
            cell.for6hourWeatherLabel.text = currentWeatherData.for6hourWeatherLabel
            cell.for6hourImage.image = UIImage(named: currentWeatherData.for6hourImage)
            returnCell = cell
        case 8:
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Forecast12HCell", forIndexPath: indexPath) as! Forecast12HCell
            cell.contentView.frame = cell.bounds
            cell.contentView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
            cell.for12hourTimeLabel.text = currentWeatherData.for12hourTimeLabel
            cell.for12hourTempLabel.text = currentWeatherData.for12hourTempLabel
            cell.for12hourWeatherLabel.text = currentWeatherData.for12hourWeatherLabel
            cell.for12hourImage.image = UIImage(named: currentWeatherData.for12hourImage)
            returnCell = cell
            
        default:
            return returnCell
        }
        return returnCell
    }

    
    // MARK: UICollectionViewDelegate


    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        

        
        return CGSizeMake( self.view.frame.width / 3 , 120)
        
    }


    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */

    
        

}
