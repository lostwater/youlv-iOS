//
//  TranslucentNavBarController.swift
//  Youlv
//
//  Created by Lost on 14/04/2015.
//  Copyright (c) 2015 Ramy. All rights reserved.
//

import UIKit

class TranslucentNavController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavBar();
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func setNavBar()
    {
        
        navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        
        //navigationBar.shadowImage = UIImage()
        //navigationBar.translucent = true
        navigationBar.translucent = false;
        navigationBar.tintColor = UIColor.whiteColor();
        navigationBar.backItem?.title = "";
        var navAppearance = UINavigationBar.appearance();
        navAppearance.titleTextAttributes =
            [
                NSFontAttributeName: UIFont(name: "HelveticaNeue", size: 24)!,
                NSForegroundColorAttributeName:UIColor.whiteColor()
        ];
        navAppearance.barTintColor = UIColorFromRGB(0x00B1F1)
        //UIStatusBar
        
        //self.view.backgroundColor=UIColor.blueColor();
        
    }
    
    func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent;
    }

   
}
