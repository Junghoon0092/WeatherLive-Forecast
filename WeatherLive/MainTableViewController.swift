
import UIKit
import CoreLocation
import ESPullToRefresh
import SwiftyJSON
import KRProgressHUD




class MainTableViewController: UITableViewController, CLLocationManagerDelegate {


    let locationManger = CLLocationManager()
    var currentLocation: CLLocation!
    
    var locationWeatherData : LocationWeatherData?
    
    var sqliteWeatherData = [SQLiteLocationWeatherData]()
    
    var currentWeatherData = CurrentWeatherData()
    
    var locationItems = [LocationItem]()

    @IBOutlet weak var leftBarButtonItem: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        
        
        locationManger.delegate = self
        locationManger.desiredAccuracy = kCLLocationAccuracyBest
        locationManger.requestWhenInUseAuthorization()
        locationManger.startMonitoringSignificantLocationChanges()
        locationManger.startUpdatingLocation()
        findLoactionItem()
        getLoactionItem()
        self.tableView.reloadData()
        self.tableView.es_addPullToRefresh {
            [weak self] in
            self!.getLoactionItem()
            LocationWeatherData.download({ (locationWeatherData) in
                self!.locationWeatherData = locationWeatherData
                self?.tableView.reloadData()
            })
            self!.findLoactionItem()
            self?.tableView.es_stopPullToRefresh(completion: true)
        }
        
        let notificationCenter = NSNotificationCenter.defaultCenter()
        notificationCenter.addObserver(self, selector: Selector(appMovedToBackgroud()), name: "good" , object: nil)

    }

    
    func appMovedToBackgroud() {
        print("backgroud")
    }
    
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
                SQLiteLocationWeatherData.SQLiteDownload(locationItem.getLatitude(), lon: locationItem.getLongitude(), completed: { (sqliteLocationWeatherData) in
                    self.sqliteWeatherData.append(sqliteLocationWeatherData)
                })
            }
            getLoactionItem()
            self.tableView.reloadData()
        }catch _ {
            print("Access Error")
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        KRProgressHUD.show()
        let delay = dispatch_time(DISPATCH_TIME_NOW, Int64(1.0 * Double(NSEC_PER_SEC)))
        dispatch_after(delay, dispatch_get_main_queue()) {
            self.loactionAuthstatus()
            self.findLoactionItem()
            KRProgressHUD.dismiss()
            self.tableView.reloadData()
            print("Check")
        }

    }

    func loactionAuthstatus() {
        if CLLocationManager.authorizationStatus() == .AuthorizedWhenInUse {
            currentLocation = locationManger.location
            
            SQLiteDataBase.sharedInstance.latitude = currentLocation.coordinate.latitude
            SQLiteDataBase.sharedInstance.longitude = currentLocation.coordinate.longitude
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

            cell.hiTempLabel.text = self.locationWeatherData?.hiTempLabel
            cell.loTempLabel.text = self.locationWeatherData?.loTempLabel
            
            if self.locationWeatherData?.todayImage == nil {
                cell.todayImage.image = UIImage(named: "Rain")
                cell.tommorwImage.image = UIImage(named: "Rain")
                cell.aftertommorwImage.image = UIImage(named: "Rain")
            } else {
                
                
                
                
                cell.todayImage.image = UIImage(named: currentWeatherData.weatherIcon((self.locationWeatherData?.todayImage)!))
                cell.tommorwImage.image = UIImage(named: (currentWeatherData.weatherIcon((self.locationWeatherData?.tomorrowImage)!)))
                cell.aftertommorwImage.image = UIImage(named: (currentWeatherData.weatherIcon((self.locationWeatherData?.afterTomorrowImage)!)))
            }
            
            cell.todayTempLabel.text = self.locationWeatherData?.todayTempLabel
            cell.afterTommorwLabel.text = self.locationWeatherData?.afterTomorrowTempLabel
            cell.tommorwTempLabel.text = self.locationWeatherData?.tomorrowTempLabel
            cell.todayWeekLabel.text = self.locationWeatherData?.todayWeekLabel
            cell.tommorwWeekLabel.text = self.locationWeatherData?.tomorrowWeekLabel
            cell.afterTommorwWeekLabel.text = self.locationWeatherData?.afterTomorrowWeekLabel
            
            returnCell = cell
            
            
        default :
            let cell = tableView.dequeueReusableCellWithIdentifier("ContryViewCell", forIndexPath: indexPath) as! ContryViewCell
            
            cell.contryCityName.text = self.sqliteWeatherData[indexPath.row - 1].cityLabel
            cell.contryTempLabel.text = self.sqliteWeatherData[indexPath.row - 1].tempLabel
            
        
            cell.contryHiTempLabel.text = self.sqliteWeatherData[indexPath.row - 1].hiTempLabel
            cell.contryLoTempLabel.text = self.sqliteWeatherData[indexPath.row - 1].loTempLabel
            
            cell.contryTodayImage.image = UIImage(named: currentWeatherData.weatherIcon(self.sqliteWeatherData[indexPath.row - 1].todayImage))
            cell.contryTommorwImage.image = UIImage(named: currentWeatherData.weatherIcon(self.sqliteWeatherData[indexPath.row - 1].tomorrowImage))
            cell.contryAftertommorwImage.image = UIImage(named: currentWeatherData.weatherIcon(self.sqliteWeatherData[indexPath.row - 1].afterTomorrowImage))
            
            
            cell.contryTodayTempLabel.text = self.sqliteWeatherData[indexPath.row - 1].todayTempLabel
            cell.contryTommorwTempLabel.text = self.sqliteWeatherData[indexPath.row - 1].tomorrowTempLabel
            cell.contryAfterTommorwLabel.text = self.sqliteWeatherData[indexPath.row - 1].afterTomorrowTempLabel
            cell.contryTodayWeekLabel.text = self.sqliteWeatherData[indexPath.row - 1].todayWeekLabel
            cell.contryTommorwWeekLabel.text = self.sqliteWeatherData[indexPath.row - 1].tomorrowWeekLabel
            cell.contryAfterTommorwWeekLabel.text = self.sqliteWeatherData[indexPath.row - 1].afterTomorrowWeekLabel
            
            returnCell = cell
            
        }
        
        return returnCell
    
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "CurrentDetail" {
            
            let path = self.tableView.indexPathForCell(sender as! UITableViewCell)
            print(path?.row)
            
            let sendValue = UIApplication.sharedApplication().delegate as? AppDelegate

            sendValue?.longitude = "\(SQLiteDataBase.sharedInstance.longitude)"
            sendValue?.latitude = "\(SQLiteDataBase.sharedInstance.latitude)"
            sendValue?.cityName = locationWeatherData?.cityLabel
        }
        
        if segue.identifier == "DataBaseDetail" {
            
            let path = self.tableView.indexPathForCell(sender as! UITableViewCell)
            print(path?.row)

            
            do {
                locationItems = try WeatherDBHelper.finaAll()!
                
                let lat = locationItems[(path?.row)! - 1 ].getLatitude()
                let long = locationItems[(path?.row)! - 1 ].getLongitude()
                let city = locationItems[(path?.row)! - 1 ].getCityName()
                print("lat : \(lat), long : \(long), cityName : \(locationItems[(path?.row)! - 1 ].getCityName())")
                
                
                let sendValue = UIApplication.sharedApplication().delegate as? AppDelegate
                sendValue?.longitude = long
                sendValue?.latitude = lat
                sendValue?.cityName = city
                
                
            }catch _ {
                print("Access Error")
            }
            
            
        }
    }
    

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
