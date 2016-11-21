//
//  SearchTVController.swift
//  WeatherLive
//
//  Created by Junghoon on 2016. 9. 29..
//  Copyright © 2016년 Junghoon. All rights reserved.
//

import UIKit
import SwiftyJSON
import KRProgressHUD
import Firebase

class SearchTVController: UIViewController, UISearchBarDelegate, UITableViewDataSource,UITableViewDelegate, GADBannerViewDelegate  {
    
    var citySearchString : String!
    
    @IBOutlet weak var bannerView: GADBannerView!
    
    
    @IBOutlet weak var tableview: UITableView!
    var searchCityData = [SearchCityData]()
    
    @IBOutlet weak var searchBarTextLoading: UISearchBar!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBarTextLoading.delegate = self
        tableview.delegate = self
        tableview.dataSource = self
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    @IBAction func cancelBTN(sender: AnyObject) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        
        let cityname = searchBar.text!
        
        searchCityDownLoad(cityname) {
            
            self.tableview.reloadData()
        }
        
        searchBar.resignFirstResponder()
        
    }
    

    func searchCityDownLoad(citystring: String, completed: DownloadComplete) {
        
        KRProgressHUD.show()
        let delay = dispatch_time(DISPATCH_TIME_NOW, Int64(1.0 * Double(NSEC_PER_SEC)))
        dispatch_after(delay, dispatch_get_main_queue()) {
            
            let findBaseURL = "http://api.openweathermap.org/data/2.5/find?q=+\(citystring)+&type=like&appid=\(API_KEY)"
            let url = NSData(contentsOfURL : NSURL(string: findBaseURL)!)
            let json = JSON(data: url!)
            if let dict = json.rawValue as? Dictionary<String, AnyObject> {
                if let list = dict["list"] as? [Dictionary<String, AnyObject>] {
                    for obj in list {
                        let searchcity = SearchCityData(searchCity: obj)
                        self.searchCityData.append(searchcity)
                    }
                }
            }
            completed()
            KRProgressHUD.dismiss()
        }
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return searchCityData.count
    }

    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("SearchCityCell", forIndexPath: indexPath) as! SearchTableViewCell

        let searchCity = searchCityData[indexPath.row]
        cell.configureCell(searchCity)
        return cell
    }
 

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    
        let database = SQLiteDataBase.sharedInstance
        
        do {
            try database.createTables()
        }
        catch _ {}
        
        
        do {
            let data = self.searchCityData[indexPath.row]
            _ = try WeatherDBHelper.insert(LocationItem(id: 0, latitude: data.lat, longitude: data.lon, cityName: data.cityName))
        }catch {
            // 알람창 구현
            print("Insert Error")
        }
    
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
//    func downloadJSONDataAll(latitude : String, longitude : String, completed: DownloadComplete ) -> Dictionary<String, AnyObject> {
//    
//        
//        
//    
//    }
    
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
