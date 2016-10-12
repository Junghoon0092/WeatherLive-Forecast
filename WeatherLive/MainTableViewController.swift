
import UIKit
import CoreLocation
import ESPullToRefresh
import SwiftyJSON


class MainTableViewController: UITableViewController, CLLocationManagerDelegate {


    let locationManger = CLLocationManager()
    var currentLocation: CLLocation!
    
    var current : CurrentWeatherData!
    var locationWeatherData : LocationWeatherData?
    var sqliteWeatherData = [SQLiteLocationWeatherData]()
    
    var currentWeatherData = CurrentWeatherData()
    
    var locationItems = [LocationItem]()
    var searchTV : SearchTVController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        locationManger.delegate = self
        locationManger.desiredAccuracy = kCLLocationAccuracyBest
        locationManger.requestWhenInUseAuthorization()
        locationManger.startMonitoringSignificantLocationChanges()
        locationManger.startUpdatingLocation()
//        findLoactionItem()
        getLoactionItem()
        
        self.tableView.es_addPullToRefresh {
            [weak self] in
            self!.getLoactionItem()
            LocationWeatherData.download({ (locationWeatherData) in
                self!.locationWeatherData = locationWeatherData
                self?.tableView.reloadData()
            })
            self?.tableView.es_stopPullToRefresh(completion: true)
        }

    }
    
    
//    func locationWeatherDataDownload(completed : DownloadComplete) {
//        
//        let url = NSData(contentsOfURL : NSURL(string: LOCATION_CURRENT_URL)!)
//        let json = JSON(data: url!)
//        if let dict = json.rawValue as? Dictionary<String, AnyObject> {
//            if let list = dict["list"] as? [[Dictionary<String, AnyObject>]] {
//                for obj in list {
//                    print(obj)
//                    let locationWeather = LocationWeatherData(locationWeatherData: obj)
//                    self.locationWeatherData.append(locationWeather)
//                }
//            }
//        }
//        
//    }
    
    
    func getLoactionItem() {
        do {
            locationItems = try WeatherDBHelper.finaAll()!
            for _ in locationItems {
            }
        }catch _ {
            print("Access Error")
        }
    }
    
    func findLoactionItem() {
        do {
            locationItems = try WeatherDBHelper.finaAll()!
            self.sqliteWeatherData.removeAll()
            for locationItem in locationItems {
                print(locationItem)
                SQLiteLocationWeatherData.SQLiteDownload(locationItem.getLatitude(), lon: locationItem.getLongitude(), completed: { (sqliteLocationWeatherData) in
                    self.sqliteWeatherData.append(sqliteLocationWeatherData)
                })
            }
            getLoactionItem()
        }catch _ {
            print("Access Error")
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        loactionAuthstatus()
        getLoactionItem()
        findLoactionItem()
        self.tableView.reloadData()
    }



    func loactionAuthstatus() {
        if CLLocationManager.authorizationStatus() == .AuthorizedWhenInUse {
            currentLocation = locationManger.location
            Location.sharedInstance.latitude = currentLocation.coordinate.latitude
            Location.sharedInstance.longitude = currentLocation.coordinate.longitude
            LocationWeatherData.download({ (locationWeatherData) in
                self.locationWeatherData = locationWeatherData
            })
        } else {
            locationManger.requestWhenInUseAuthorization()
            loactionAuthstatus()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        print("mainCount : \(sqliteWeatherData.count)")
        // #warning Incomplete implementation, return the number of rows
        return sqliteWeatherData.count + 1
    }

 
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var returnCell = UITableViewCell()
        
        switch indexPath.row {
        case 0 :
            let cell = tableView.dequeueReusableCellWithIdentifier("MainTableViewCell", forIndexPath: indexPath) as! MainTableViewCell
            
            
            cell.cityLabel.text = self.locationWeatherData?.cityLabel
            cell.tempLabel.text = self.locationWeatherData?.tempLabel
//            cell.hiTempLabel.text = locationWeatherData!.hiTempLabel
//            cell.loTempLabel.text = locationWeatherData!.loTempLabel
//            cell.todayImage.image = UIImage(named: currentWeatherData.weatherIcon(locationWeatherData!.todayImage))
//            cell.tommorwImage.image = UIImage(named: currentWeatherData.weatherIcon(locationWeatherData!.tomorrowImage))
//            cell.aftertommorwImage.image = UIImage(named: currentWeatherData.weatherIcon(locationWeatherData!.afterTomorrowImage))
//            cell.todayTempLabel.text = locationWeatherData!.todayTempLabel
//            cell.afterTommorwLabel.text = locationWeatherData!.afterTomorrowTempLabel
//            cell.tommorwTempLabel.text = locationWeatherData!.tomorrowTempLabel
//            cell.tommorwWeekLabel.text = locationWeatherData!.tomorrowWeekLabel
//            cell.afterTommorwWeekLabel.text = locationWeatherData!.afterTomorrowWeekLabel
            returnCell = cell
            
            
        default :
            let cell = tableView.dequeueReusableCellWithIdentifier("ContryViewCell", forIndexPath: indexPath) as! ContryViewCell
        
            cell.contryName.text = self.sqliteWeatherData[indexPath.row - 1].cityLabel
            print("cell :    \(self.sqliteWeatherData[indexPath.row - 1].cityLabel)")
            cell.contryTempLabel.text = self.sqliteWeatherData[indexPath.row - 1].tempLabel
            
            returnCell = cell
    
        }
        
        return returnCell
    
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
        
    }
    
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        
//        if segue.identifier == "WeatherDetail" {
//            
//            let param = locationWeatherData.cityLabel
//            
//            (segue.destinationViewController as? PageMenuViewController)?.titleLabel = param
//        }
//        
//    }
    
    
//    func currentWeaterDataCheck (lat : String, lon : String, completed: DownloadComplete)  {
//        
//        let findBaseURL = "\(FORECAST_16DAY_BASE)lat=\(lat)&lon=\(lon)&units=metric&appid=\(API_KEY)"
//        let url = NSData(contentsOfURL : NSURL(string: findBaseURL)!)
//        let json = JSON(data: url!)
//        if let dict = json.rawValue as? Dictionary<String, AnyObject> {
//            if let list = dict["list"] as? [Dictionary<String, AnyObject>] {
//                for obj in list {
//                    let searchcity = SearchCityData(searchCity: obj)
//                    self.searchCityData.append(searchcity)
//                }
//            }
//        }
//        completed()
//    }
    
    
    
    


    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */


    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if editingStyle == .Delete {
            
            let mainCellItem = locationItems[indexPath.row - 1]
            do {
                try WeatherDBHelper.delete(mainCellItem)
                getLoactionItem()
            }
            catch _ {
                print("Do not Delete")
            }
            sqliteWeatherData.removeAtIndex(indexPath.row - 1)
            
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
        
        
    }


    override func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        
        var style = UITableViewCellEditingStyle.Delete
        if indexPath.row == 0 {
            style = UITableViewCellEditingStyle.None
            return style
        } else {
            return style
        }

    }
    
    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
}
