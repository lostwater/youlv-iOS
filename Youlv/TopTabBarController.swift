//
//  TopTabBarController.swift
//  Youlv
//
//  Created by Lost on 10/04/2015.
//  Copyright (c) 2015 Ramy. All rights reserved.
//

import UIKit

class TopTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        reLocTabBar();
        setTabBar();
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func reLocTabBar()
    {

        if self.navigationController != nil
        {
            var y =  self.navigationController?.navigationBar.frame.size.height;
            tabBar.frame = CGRectMake(0,self.navigationController!.navigationBar.frame.origin.y + navigationController!.navigationBar.frame.size.height,tabBar.frame.size.width,tabBar.frame.size.height);
            
        }
     }
    
    func setTabBar()
    {
        tabBar.backgroundImage = UIImage()
        //var bg = UIToolbar(frame: CGRectMake(tabBar.frame.origin.x, tabBar.frame.origin.y, tabBar.frame.size.width, 86))
        //bg.setBackgroundImage(UIImage(named: "bgtabbar86px"), forToolbarPosition: UIBarPosition.Any, barMetrics: UIBarMetrics.Default)
        //self.view.addSubview(bg);
        
        var bgframe = CGRectMake(0, tabBar.frame.origin.y, tabBar.frame.size.width, 35);
        var bgImage = UIImage(named: "bgtabbar86px")
        var bgIV = UIImageView(frame: bgframe);
        bgIV.image = bgImage;
        bgIV.contentMode = UIViewContentMode.ScaleToFill;
        view.addSubview(bgIV);
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
