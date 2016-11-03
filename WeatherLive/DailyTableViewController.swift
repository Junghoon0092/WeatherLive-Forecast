//
//  DailyTableViewController.swift
//  WeatherLive
//
//  Created by Junghoon on 2016. 9. 5..
//  Copyright © 2016년 Junghoon. All rights reserved.
//

import UIKit
import SwiftyJSON

class DailyTableViewController: UITableViewController {
    
    var dailyWeatherDatas = [DailyWeatherData]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let sendValue = UIApplication.sharedApplication().delegate as? AppDelegate
        
        self.downloadDailyForecast((sendValue?.latitude)!, long: (sendValue?.longitude)!) {
            
            self.tableView.reloadData()
        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func downloadDailyForecast(lat : String, long : String, completed: DownloadComplete) {
        
        let sendValue = UIApplication.sharedApplication().delegate as? AppDelegate
        var unit : String = ""
        if sendValue?.tempCheck == true {
            unit = "metric"
        } else {
            unit = "imperial"
        }
        
        let findBaseURL = "\(FORECAST_16DAY_BASE)lat=\(lat)&lon=\(long)&units=\(unit)&appid=\(API_KEY)"
        let url = NSData(contentsOfURL : NSURL(string: findBaseURL)!)
    
        let json = JSON(data: url!)
        if let dict = json.rawValue as? Dictionary<String, AnyObject> {
            if let list = dict["list"] as? [Dictionary<String, AnyObject>] {
                for obj in list {
                    let dailyForecast = DailyWeatherData(dailyWeatherData: obj)
                    self.dailyWeatherDatas.append(dailyForecast)
                }
                
            }
        }
        completed()
    }
    
    
    

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return dailyWeatherDatas.count
    }

  
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
       if let cell = tableView.dequeueReusableCellWithIdentifier("DailyTableViewCell", forIndexPath: indexPath) as? DailyTableViewCell {
            
            let dailyForecast = dailyWeatherDatas[indexPath.row]
            cell.configureCell(dailyForecast)
            return cell
        }else {
            return DailyTableViewCell()
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
