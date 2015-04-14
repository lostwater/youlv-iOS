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
        navigationBar.shadowImage = UIImage()
        navigationBar.translucent = true
        navigationBar.tintColor = UIColor.whiteColor();
        navigationBar.backItem?.title = "";
        var navAppearance = UINavigationBar.appearance();
        navAppearance.titleTextAttributes =
            [
                NSFontAttributeName: UIFont(name: "HelveticaNeue", size: 24)!,
                NSForegroundColorAttributeName:UIColor.whiteColor()
        ];
        
        //self.view.backgroundColor=UIColor.blueColor();
        
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent;
    }

   
}
