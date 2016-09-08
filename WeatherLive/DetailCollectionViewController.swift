//
//  DetailCollectionViewController.swift
//  WeatherLive
//
//  Created by Junghoon on 2016. 9. 5..
//  Copyright © 2016년 Junghoon. All rights reserved.
//

import UIKit
import Alamofire

class DetailCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var currentWeatherData = CurrentWeatherData()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentWeatherData.downloadSwiftyJSONData()
        currentWeatherData.downloadSwiftyJSONDataForcasting()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        collectionView?.backgroundColor = UIColor.whiteColor()
        
        // Register cell classes
//      collectionView?.registerClass(TemperatureCell.self, forCellWithReuseIdentifier: "TemperatureCell")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        return 7
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        var returnCell = UICollectionViewCell()
        
        switch indexPath.row {
        case 0 :
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("TemperatureCell", forIndexPath: indexPath) as! TemperatureCell
            cell.titit.text = currentWeatherData.temperature
            cell.hiLowTempLabel.text = "Hi : \(currentWeatherData.hiTemperature)  Lo : \(currentWeatherData.loTemperature)"
            returnCell = cell
        case 1:
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("WindCell", forIndexPath: indexPath) as! WindCell
            cell.windSpeedLabel.text = currentWeatherData.windSpeed
            returnCell = cell
        case 2:
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("HumidityCell", forIndexPath: indexPath) as! HumidityCell
            cell.humiLabel.text = currentWeatherData.humidity
            returnCell = cell
        case 3:
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CloudsCell", forIndexPath: indexPath) as! CloudsCell
            cell.cloudsLabel.text = currentWeatherData.clouds
            returnCell = cell
        case 4:
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("SunriseCell", forIndexPath: indexPath) as! SunriseCell
            cell.sunRiseLabel.text = currentWeatherData.sunrise
            returnCell = cell
        case 5:
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("SunsetCell", forIndexPath: indexPath) as! SunsetCell
            cell.sunSetLabel.text = currentWeatherData.sunset
            returnCell = cell
        case 6:
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Forecast3HCell", forIndexPath: indexPath) as! Forecast3HCell
            cell.for3hourTimeLabel.text = currentWeatherData.for3hourTimeLabel
            cell.for3hourTempLabel.text = currentWeatherData.for3hourTempLabel
            cell.for3hourWeatherLabel.text = currentWeatherData.for3hourWeatherLabel
            cell.for3hourImage.image = UIImage(named: currentWeatherData.for3hourImage)
            print(currentWeatherData._for3hourImage)
            returnCell = cell
        default:
            return returnCell
        }
        return returnCell
    }

    
    // MARK: UICollectionViewDelegate


    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        return CGSizeMake( view.frame.width / 3 , 120)
        
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
