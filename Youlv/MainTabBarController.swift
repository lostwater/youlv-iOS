		//
//  MainTabBarController.swift
//  Youlv
//
//  Created by Lost on 10/04/2015.
//  Copyright (c) 2015 Ramy. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        addCenterButton();
        self.navigationController?.navigationBar.backgroundColor=UIColor.blueColor();
        var homeStoryBoard = UIStoryboard(name:"Home",bundle:nil)
        var vc = homeStoryBoard.instantiateInitialViewController() as UIViewController
        self.viewControllers?[0]=vc;
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addCenterButton()
    {
        var centerButton = UIButton();
        centerButton.frame = CGRectMake(0,0,50,50);
        centerButton.backgroundColor = UIColor.blackColor();
        centerButton.setTitle("Add", forState: UIControlState.Normal);
        centerButton.center = self.tabBar.center;
        centerButton.addTarget(self,action:Selector("buttonTapped"),forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(centerButton);
        
    }
    
    func buttonTapped()
    {
        var newVC = self.storyboard!.instantiateViewControllerWithIdentifier("newViewController") as UIViewController
        self.presentViewController(newVC as UIViewController,animated:true,completion:nil)
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

