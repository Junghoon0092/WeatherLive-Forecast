//
//  SettingViewTVController.swift
//  WeatherLive
//
//  Created by Junghoon on 2016. 11. 2..
//  Copyright © 2016년 Junghoon. All rights reserved.
//

import UIKit
import MessageUI
import StoreKit
import SwiftyStoreKit

class SettingViewTVController: UITableViewController, MFMailComposeViewControllerDelegate {
    
    @IBOutlet weak var tempCheckSwitch: UISwitch!
    @IBOutlet weak var tempCheckLabel: UILabel!
    
    @IBOutlet weak var removeAdButton: UILabel!
    @IBOutlet weak var coffeePrice: UILabel!
    @IBOutlet weak var cakePrice: UILabel!
    @IBOutlet weak var dinnerPrice: UILabel!
    
    
    
    
    func inAppPriceLocalized() {
        
        SwiftyStoreKit.retrieveProductsInfo(["remove"]) { (result) in
            
            let product = result.retrievedProducts.first
            self.removeAdButton.text = "Remove Ad ( \(product!.localizedPrice()) )"
        }
        SwiftyStoreKit.retrieveProductsInfo(["GiftCoffee"]) { (result) in
            
            let product = result.retrievedProducts.first
            self.coffeePrice.text = product!.localizedPrice()
        }
        SwiftyStoreKit.retrieveProductsInfo(["GiftCake"]) { (result) in
            
            let product = result.retrievedProducts.first
            self.cakePrice.text = product!.localizedPrice()
        }
        SwiftyStoreKit.retrieveProductsInfo(["GiftDinner"]) { (result) in
            
            let product = result.retrievedProducts.first
            self.dinnerPrice.text = product!.localizedPrice()
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        inAppPriceLocalized()
        
        let sendValue = UIApplication.sharedApplication().delegate as? AppDelegate
        
        if sendValue?.tempCheck == true {
            tempCheckSwitch.on = true
            tempCheckLabel.text = NSLocalizedString("TemperCheckCelsius", comment: "TemperCheckCelsius")
            
            
        } else {
            tempCheckSwitch.on = false
            tempCheckLabel.text = NSLocalizedString("TemperCheckFtahrenheit", comment: "TemperCheckFtahrenheit")
            
        }
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if let indexPaht = tableView.indexPathForSelectedRow {
            tableView.deselectRowAtIndexPath(indexPaht, animated: true)
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
            return NSLocalizedString("Information", comment: "Information")

        case 1:
            return NSLocalizedString("Remove Ad", comment: "Remove Ad")
        case 2:
            return NSLocalizedString("Help Developer", comment: "Help Developer")
        default:
            return ""
        }
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
        tableView.deselectRowAtIndexPath(indexPath, animated:true)
        
        
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
            
        } else if indexPath.section == 1 {
            switch indexPath.row {
            case 0:
                
                SwiftyStoreKit.purchaseProduct("remove") { result in
                    switch result {
                    case .Success(let productId):
                        
                        let appdelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                        appdelegate.adMobCheck = false
                        NSUserDefaults.standardUserDefaults().setBool(true, forKey: "adMob")
                        print("Purchase Success: \(productId)")
                        
                    case .Error(let error):
                        print("Purchase Failed: \(error)")
                        switch error {
                        case .Failed(let error):
                            if error.domain == SKErrorDomain {
                                self.alertWithTitle("Purchase failed", message: "Please check your Internet connection or try again later")
                            }
                            self.alertWithTitle("Purchase failed", message: "Unknown error. Please contact support")
                            
                        case .InvalidProductId(let productId):
                            self.alertWithTitle("Purchase failed", message: "\(productId) is not a valid product identifier")
                            
                        case .NoProductIdentifier:
                            self.alertWithTitle("Purchase failed", message: "Product not found")
                            
                        case .PaymentNotAllowed:
                            self.alertWithTitle("Payments not enabled", message: "You are not allowed to make payments")
                        }
                    }
                }
                
                
            case 1:
                SwiftyStoreKit.restorePurchases({ (results) in
               
                    self.showAlert(self.alertForRestorePurchases(results))
                    
                })
                
            default:
                break
            }
            
        }
        /*
             이쁜 주석
             */
        else if indexPath.section == 2 {
            switch indexPath.row {
            case 0:
                
                SwiftyStoreKit.purchaseProduct("GiftCoffee") { result in
                    
                    self.showAlert(self.alertForPurchaseResult(result))
                    
                }
                
            case 1:
                
                SwiftyStoreKit.purchaseProduct("GiftCake") { result in
                    
                    self.showAlert(self.alertForPurchaseResult(result))
                    
                }
            case 2:
                
                SwiftyStoreKit.purchaseProduct("GiftDinner") { result in
                    
                    self.showAlert(self.alertForPurchaseResult(result))
                    
                }
                
                
            default:
                break
            }
            
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
    
    func alertForPurchaseResult(result: SwiftyStoreKit.PurchaseResult) -> UIAlertController {
        switch result {
        case .Success(let productId):
            print("Purchase Success: \(productId)")
            return alertWithTitle("Thank You", message: "Purchase completed")
        case .Error(let error):
            print("Purchase Failed: \(error)")
            switch error {
            case .Failed(let error):
                if error.domain == SKErrorDomain {
                    return alertWithTitle("Purchase failed", message: "Please check your Internet connection or try again later")
                }
                return alertWithTitle("Purchase failed", message: "Unknown error. Please contact support")
            case .InvalidProductId(let productId):
                return alertWithTitle("Purchase failed", message: "\(productId) is not a valid product identifier")
            case .NoProductIdentifier:
                return alertWithTitle("Purchase failed", message: "Product not found")
            case .PaymentNotAllowed:
                return alertWithTitle("Payments not enabled", message: "You are not allowed to make payments")
            }
        }
    }
    
    func alertForRestorePurchases(results: SwiftyStoreKit.RestoreResults) -> UIAlertController {
        
        if results.restoreFailedProducts.count > 0 {
            print("Restore Failed: \(results.restoreFailedProducts)")
            return alertWithTitle("Restore failed", message: "Unknown error. Please contact support")
        }
        else if results.restoredProductIds.count > 0 {
            print("Restore Success: \(results.restoredProductIds)")
            
            let appdelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            appdelegate.adMobCheck = false
            NSUserDefaults.standardUserDefaults().setBool(true, forKey: "adMob")
            
            return alertWithTitle("Purchases Restored", message: "All purchases have been restored")
        }
        else {
            print("Nothing to Restore")
            return alertWithTitle("Nothing to restore", message: "No previous purchases were found")
        }
    }
    
    
    
}

extension SettingViewTVController {
    
    
    func alertWithTitle(title: String, message: String) -> UIAlertController {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Cancel, handler: nil))
        return alert
    }
    func showAlert(alert: UIAlertController) {
        guard let _ = self.presentedViewController else {
            self.presentViewController(alert, animated: true, completion: nil)
            return
        }
    }
}



extension SKProduct {
    
    func localizedPrice() -> String {
        let numberFormatter = NSNumberFormatter()
        numberFormatter.locale = self.priceLocale
        numberFormatter.numberStyle = .CurrencyStyle
        let priceString = numberFormatter.stringFromNumber(self.price ?? 0) ?? ""
        return priceString
    }
    
}







