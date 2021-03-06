//
//  AppDelegate.swift
//  WeatherLive
//
//  Created by Junghoon on 2016. 9. 5..
//  Copyright © 2016년 Junghoon. All rights reserved.
//

import UIKit
import Firebase
import SwiftyStoreKit


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    var latitude : String! = ""
    var longitude : String! = ""
    var cityName : String! = ""
    var tempCheck : Bool = true
    var adMobCheck : Bool = true
    
    var settingItems = [SettingItem]()
    
    var mainView = MainTableViewController()


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        
        GADMobileAds.configureWithApplicationID("ca-app-pub-3163253994374354/5176385829")
    
        let database = SQLiteDataBase.sharedInstance
        
        do {
            try database.createTables()
            settingItems = try SettingDBHelper.finaAll()!
            for settingItem in settingItems {
                if settingItem.getTempCheck() == 0 {
                    self.tempCheck = false
                
                } else {
                    self.tempCheck = true
                    print("켜기")
                }
            }
        }
        catch _ {
            print("Delegate SQLite Access Error")
        }
        
        if NSUserDefaults.standardUserDefaults().boolForKey("adMob") {
            print(NSUserDefaults.standardUserDefaults().boolForKey("adMob"))
            self.adMobCheck = false
        } else {
            self.adMobCheck = true
        }

        completeIAPTransactions()
        
        // Override point for customization after application launch.
        return true
    }

    func completeIAPTransactions() {
        
        SwiftyStoreKit.completeTransactions() { completedTransactions in
            
            for completedTransaction in completedTransactions {
                
                if completedTransaction.transactionState == .Purchased || completedTransaction.transactionState == .Restored {
                    
                    print("purchased: \(completedTransaction.productId)")
                }
            }
        }
    }
    
    func applicationWillResignActive(application: UIApplication) {
        let nc = window?.rootViewController as! UINavigationController
        nc.popToRootViewControllerAnimated(true)
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        sleep(2)
        let nc = window?.rootViewController as! UINavigationController
        nc.popToRootViewControllerAnimated(true)
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
       

        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

