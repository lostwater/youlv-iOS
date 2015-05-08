//
//  AppDelegate.swift
//  Youlv
//
//  Created by Lost on 09/04/2015.
//  Copyright (c) 2015 Ramy. All rights reserved.
//

let appBlueColor = UIColorFromRGB(0x00B1F1)
var appNaviMenuView : UIView?
var isCancellingNew = false

func UIColorFromRGB(rgbValue: UInt) -> UIColor {
    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}


import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        //DataManager().getOrderList(1, pageSize: 10)
        setAppearance()
        application.setStatusBarStyle(UIStatusBarStyle.LightContent, animated: true)
        		
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
        //navigationBar.shadowImage = UIImage()
        //navigationBar.translucent = true
        UINavigationBar.appearance().translucent = false;
        UINavigationBar.appearance().tintColor = UIColor.whiteColor();
        UINavigationBar.appearance().backItem?.title = "";
        UINavigationBar.appearance().titleTextAttributes =
            [
                NSFontAttributeName: UIFont(name: "HelveticaNeue", size: 24)!,
                NSForegroundColorAttributeName:UIColor.whiteColor()
        ];
        UINavigationBar.appearance().barTintColor = UIColorFromRGB(0x00B1F1)
        UIBarButtonItem.appearance().setBackButtonBackgroundImage(UIImage(named: "buttonarrowleftwhite"), forState: UIControlState.Normal, barMetrics: UIBarMetrics.Default)
        UIBarButtonItem.appearance().setBackButtonTitlePositionAdjustment(UIOffset(horizontal: -500, vertical: 0), forBarMetrics: UIBarMetrics.Default)
    

        
    }
    
    func setAppearance()
    {
        //UITableViewCell.appearance().accessoryView = UIImageView(image: UIImage(named: "buttonarrowsrightblue")) as UIView
        setNavBar()
    }
    
    func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }




} 

