
import UIKit
import CoreLocation


class MainTableViewController: UITableViewController, CLLocationManagerDelegate {


    let locationManger = CLLocationManager()
    var currentLocation: CLLocation!
    
    var current : CurrentWeatherData!
    var locationWeatherData = LocationWeatherData()
    var currentWeatherData = CurrentWeatherData()
    
    var locationItems = [LocationItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManger.delegate = self
        locationManger.desiredAccuracy = kCLLocationAccuracyBest
        locationManger.requestWhenInUseAuthorization()
        locationManger.startMonitoringSignificantLocationChanges()
        locationManger.startUpdatingLocation()
        loactionAuthstatus()
        getLoactionItem()

    }
    
//    override func viewDidAppear(animated: Bool) {
//        super.viewDidAppear(animated)
//        loactionAuthstatus()
//    }
    
    func getLoactionItem() {
        do {
            locationItems = try WeatherDBHelper.finaAll()!
            for loactionitem in locationItems {
                print(loactionitem.getCityName())
            }
        }catch _ {
            print("Access Error")
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        self.tableView.reloadData()
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
    }

    func loactionAuthstatus() {
        if CLLocationManager.authorizationStatus() == .AuthorizedWhenInUse {
            currentLocation = locationManger.location
            Location.sharedInstance.latitude = currentLocation.coordinate.latitude
            Location.sharedInstance.longitude = currentLocation.coordinate.longitude
            locationWeatherData.loactionWeatherDataJSON({
                self.tableView.reloadData()
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
        return locationItems.count + 1
    }

 
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var returnCell = UITableViewCell()
        
        switch indexPath.row {
        case 0 :
            let cell = tableView.dequeueReusableCellWithIdentifier("MainTableViewCell", forIndexPath: indexPath) as! MainTableViewCell
            
            cell.cityLabel.text = locationWeatherData.cityLabel
            cell.tempLabel.text = locationWeatherData.tempLabel
            cell.hiTempLabel.text = locationWeatherData.hiTempLabel
            cell.loTempLabel.text = locationWeatherData.loTempLabel
            cell.todayImage.image = UIImage(named: currentWeatherData.weatherIcon(locationWeatherData.todayImage))
            cell.tommorwImage.image = UIImage(named: currentWeatherData.weatherIcon(locationWeatherData.tomorrowImage))
            cell.aftertommorwImage.image = UIImage(named: currentWeatherData.weatherIcon(locationWeatherData.afterTomorrowImage))
            cell.todayTempLabel.text = locationWeatherData.todayTempLabel
            cell.afterTommorwLabel.text = locationWeatherData.afterTomorrowTempLabel
            cell.tommorwTempLabel.text = locationWeatherData.tomorrowTempLabel
            cell.tommorwWeekLabel.text = locationWeatherData.tomorrowWeekLabel
            cell.afterTommorwWeekLabel.text = locationWeatherData.afterTomorrowWeekLabel
            
            returnCell = cell
        case 1 :
            let cell = tableView.dequeueReusableCellWithIdentifier("MainTableViewCell", forIndexPath: indexPath) as! MainTableViewCell
            
            cell.cityLabel.text = locationWeatherData.cityLabel
 
            
            returnCell = cell
        
            
        default:
            return returnCell
        }
        
        return returnCell
    
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "WeatherDetail" {
            
            let param = locationWeatherData.cityLabel
            
            (segue.destinationViewController as? PageMenuViewController)?.titleLabel = param
        }
        
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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
