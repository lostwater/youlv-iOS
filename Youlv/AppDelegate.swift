//
//  AppDelegate.swift
//  Youlv
//
//  Created by Lost on 09/04/2015.
//  Copyright (c) 2015 Ramy. All rights reserved.
//

import UIKit

let appBlueColor = UIColorFromRGB(0x00B1F1)
let bgGreyColor = UIColorFromRGB(0xF1F0F5)
let bgNaviColor = UIColor(white: 0, alpha: 0.1)

var appNaviMenuView : UIView?
var headImage = UIImage(named:"pichead")
var defualtPic = UIImage(named:"th.jpeg")


func UIColorFromRGB(rgbValue: UInt) -> UIColor {
    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}

var sessionId = "76153026bac352110d4cd6a4dbb295d6"
var myLawyerId = 0
var myAccount = ""
var defaultDateFormatter = NSDateFormatter()

let infoDict = NSBundle.mainBundle().infoDictionary
let majorVersion = infoDict?["CFBundleShortVersionString"] as? String
let minorVersion = infoDict?["CFBundleVersion"] as? String

let groupMaxUsers = 300
let serviceName = "com.RamyTech.Youlv"

var userDefaults = NSUserDefaults.standardUserDefaults()
var httpClient = HTTPClient()


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        //DataManager().getOrderList(1, pageSize: 10)
        defaultDateFormatter.dateFormat="yyyy.MM.dd HH:mm"
        setAppearance()
        application.setStatusBarStyle(UIStatusBarStyle.LightContent, animated: true)
        
        var apnsCertName = "propush"
        #if DEBUG
            apnsCertName = "devpush";
        #else
            apnsCertName = "propush";
        #endif
        
        EaseMob.sharedInstance().registerSDKWithAppKey("yoolegal#yoolegal", apnsCertName: apnsCertName)
        EaseMob.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        
        
        IQKeyboardManager.sharedManager().enable = true
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
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
    
    
    
    
    func setNavBar()
    {
        
        
        UINavigationBar.appearance().setBackgroundImage(UIImage(named: "alpha0"), forBarMetrics: UIBarMetrics.Default)
        UINavigationBar.appearance().shadowImage = UIImage(named: "alpha0");
        //UINavigationBar.appearance().backgroundColor = UIColor.blackColor()
        //navigationBar.shadowImage = UIImage()
        //navigationBar.translucent = true
        UINavigationBar.appearance().translucent = false;
        UINavigationBar.appearance().tintColor = UIColor.whiteColor();
        UINavigationBar.appearance().backItem?.title = "";
        UINavigationBar.appearance().titleTextAttributes =
            [
                NSFontAttributeName: UIFont(name: "HelveticaNeue", size: 16)!,
                NSForegroundColorAttributeName:UIColor.whiteColor()
        ];
        UINavigationBar.appearance().barTintColor = appBlueColor
        UINavigationBar.appearance().backIndicatorImage = UIImage(named: "buttonarrowsleftwhite")
        //UIBarButtonItem.appearance().setBackButtonBackgroundImage(UIImage(named: "arrows_left"), forState: UIControlState.Normal, barMetrics: UIBarMetrics.Default)
        UIBarButtonItem.appearance().setBackButtonTitlePositionAdjustment(UIOffset(horizontal: -500, vertical: 0), forBarMetrics: UIBarMetrics.Default)
        
    }
    
    
    func setTableViewSeprator()
    {
        UITableView.appearance().separatorInset = UIEdgeInsetsZero
        UITableViewCell.appearance().separatorInset = UIEdgeInsetsZero
        UITableView.appearance().layoutMargins = UIEdgeInsetsZero
        UITableViewCell.appearance().layoutMargins = UIEdgeInsetsZero
        UITableViewCell.appearance().preservesSuperviewLayoutMargins = false
        
//        if #available(iOS 8.0, *) {
//            UITableView.appearance().layoutMargins = UIEdgeInsetsZero
//        } else {
//            // Fallback on earlier versions
//        }
//        if #available(iOS 8.0, *) {
//            UITableViewCell.appearance().layoutMargins = UIEdgeInsetsZero
//        } else {
//            // Fallback on earlier versions
//        }
//        if #available(iOS 8.0, *) {
//            UITableViewCell.appearance().preservesSuperviewLayoutMargins = false
//        } else {
//            // Fallback on earlier versions
//        }
    }
    
    func setAppearance()
    {
        //UITableViewCell.appearance().accessoryView = UIImageView(image: UIImage(named: "buttonarrowsrightblue")) as UIView
        setNavBar()
        setTableViewSeprator()
    }
    





} 

