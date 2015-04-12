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
            tabBar.frame = CGRectMake(0,y!,tabBar.frame.size.width,tabBar.frame.size.height);
            
        }
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
