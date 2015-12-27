//
//  AppDelegate.swift
//  Tip Calculator
//
//  Created by Vincent Duong on 12/15/15.
//  Copyright © 2015 Vincent Duong. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    var dict_Item_Names: NSMutableDictionary = NSMutableDictionary()

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        
        let documentDirectoryPath = paths[0] as String
        
        let plistFilePathInDocumentDirectory = documentDirectoryPath + "/PastBills.plist"
        
        let dictionaryFromFile: NSMutableDictionary? = NSMutableDictionary(contentsOfFile: plistFilePathInDocumentDirectory)
        
        /*
        IF the optional variable dictionaryFromFile has a value, THEN
        PastBills.plist exists in the Documents directory and the dictionary is successfully created
        ELSE read PastBills.plist from the application's main bundle.
        */
        if let dictionaryFromFileInDocumentDirectory = dictionaryFromFile {
            // Inventory.plist exists in the Documents directory
            dict_Item_Names = dictionaryFromFileInDocumentDirectory
        } else {
            // Inventory.plist does not exist in the Documents directory; Read it from the main bundle.
            // Obtain the file path to the plist file in the mainBundle (project folder)
            let plistFilePathInMainBundle = NSBundle.mainBundle().pathForResource("PastBills", ofType: "plist")
            
            // Instantiate an NSMutableDictionary object and initialize it with the contents of the PastBills.plist file.
            let dictionaryFromFileInMainBundle: NSMutableDictionary? = NSMutableDictionary(contentsOfFile: plistFilePathInMainBundle!)
            
            // Assign it to the instance variable
            dict_Item_Names = dictionaryFromFileInMainBundle!
        }


        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        let documentDirectoryPath = paths[0] as String
        let plistFilePathInDocumentDirectory = documentDirectoryPath + "/PastBills.plist"
        
        dict_Item_Names.writeToFile(plistFilePathInDocumentDirectory, atomically: true)
    }

    func applicationDidEnterBackground(application: UIApplication) {
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

