//
//  SettingViewTVController.swift
//  WeatherLive
//
//  Created by Junghoon on 2016. 11. 2..
//  Copyright © 2016년 Junghoon. All rights reserved.
//

import UIKit
import MessageUI

class SettingViewTVController: UITableViewController,MFMailComposeViewControllerDelegate {

    @IBOutlet weak var tempCheckSwitch: UISwitch!
    @IBOutlet weak var tempCheckLabel: UILabel!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let sendValue = UIApplication.sharedApplication().delegate as? AppDelegate
        
        if sendValue?.tempCheck == true {
            tempCheckSwitch.on = true
            tempCheckLabel.text = NSLocalizedString("TemperCheckCelsius", comment: "TemperCheckCelsius")
            
            
        } else {
            tempCheckSwitch.on = false
            tempCheckLabel.text = NSLocalizedString("TemperCheckFtahrenheit", comment: "TemperCheckFtahrenheit")
            
        }

        
        
    }
    
    @IBAction func checkSwitch(sender: AnyObject) {
        
        let sendValue = UIApplication.sharedApplication().delegate as? AppDelegate
        
        if tempCheckSwitch.on == false {
            do {
                _ = try SettingDBHelper.update(SettingItem(id: 0, tempCheck: 0))
                sendValue?.tempCheck = false
                print("false / update : 0번")
            } catch {
                do {
                    _ = try SettingDBHelper.insert(SettingItem(id: 0, tempCheck: 0))
                    sendValue?.tempCheck = false
                    print("false / insert : 0번")
                }catch {
                    print("false / insert : Error")
                }
            }
            tempCheckLabel.text = NSLocalizedString("TemperCheckFtahrenheit", comment: "TemperCheckFtahrenheit")
        } else {
            do {
                _ = try SettingDBHelper.update(SettingItem(id: 0, tempCheck: 1))
                sendValue?.tempCheck = true
                print("true / update : 1번")
            } catch {
                do {
                    _ = try SettingDBHelper.insert(SettingItem(id: 0, tempCheck: 1))
                    sendValue?.tempCheck = true
                    print("true / insert : 1번")
                }catch {
                    print("false / insert : Error")
                }
            }
            tempCheckLabel.text = NSLocalizedString("TemperCheckCelsius", comment: "TemperCheckCelsius")
        }
        
    }
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        
        controller.dismissViewControllerAnimated(true, completion: nil)
    }


    @IBAction func settingDonebutton(sender: AnyObject) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
   
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch section {
        case 0:
            return 2
        case 1:
            return 2
        case 2:
            return 3
        default:
            return 0
        }
    }

    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        switch section {
        case 0:
            return "Information"
        case 1:
            return "Remove Ad"
        case 2:
            return "Support Developer"
        default:
            return ""
        }
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
        if indexPath.section == 0 {
            
            switch indexPath.row {
            case 0 :
                
                let infoDic = NSBundle.mainBundle().infoDictionary!
                let appName = infoDic["CFBundleName"] as! String
                let appVersion = infoDic["CFBundleShortVersionString"] as! String
                let appOSVersion = UIDevice.currentDevice().systemVersion
                
                let mailComposerVC = MFMailComposeViewController()
                mailComposerVC.mailComposeDelegate = self
                mailComposerVC.setToRecipients(["coolmint.swift@gmail.com"])
                mailComposerVC.setSubject(String(format: NSLocalizedString("[%@-Feedback]", comment: "[%@-Feedback]"), appName ))
                
                mailComposerVC.setMessageBody(String(format: NSLocalizedString("\n \n \nThank you for your feedback. \n App Name : %@ \n App Version : %@ \n iOS Version : %@", comment: "1"), appName, appVersion, appOSVersion ), isHTML: false)
                
                if MFMailComposeViewController.canSendMail() {
                    self.presentViewController(mailComposerVC, animated: true, completion: nil)
                    print("can send mail")
                    
                } else {
                    
                    let sendMailErrorAlert = UIAlertController(title: "Mail Fail", message: "Please, recheck your E-Mail Account", preferredStyle: .Alert )
                    sendMailErrorAlert.actions
                    
                }
            default:
                print("00")
            }
            
        }
        
        
    }



    
    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

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
