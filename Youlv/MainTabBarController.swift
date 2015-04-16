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

                setTabBarItems();
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setTabBarItems()
    {
        var homeStoryBoard = UIStoryboard(name:"Home",bundle:nil)
        var vc = homeStoryBoard.instantiateInitialViewController() as! UIViewController
        self.viewControllers?[0]=vc;
        vc.tabBarItem.title = " ";
        vc.title = ""

        var messssageStoryBorad = UIStoryboard(name:"Messages",bundle:nil)
        self.viewControllers?[1] = messssageStoryBorad.instantiateInitialViewController() as! UIViewController
        
        let normalimage1 = UIImage(named: "buttonhomepagegrey") as UIImage?
        let selectedimage1 = UIImage(named: "buttonhomepageblue") as UIImage?
        let normalimage2 = UIImage(named: "buttonmessagegrey") as UIImage?
        let selectedimage2 = UIImage(named: "buttonmessageblue") as UIImage?
        let normalimage3 = UIImage(named: "buttondiscoverygrey") as UIImage?
        let selectedimage3 = UIImage(named: "buttondiscoveryblue") as UIImage?
        let normalimage4 = UIImage(named: "buttonmegrey") as UIImage?
        let selectedimage4 = UIImage(named: "buttonmeblue") as UIImage?
        viewControllers?[0].tabBarItem?.selectedImage = selectedimage1
        viewControllers?[0].tabBarItem?.image = normalimage1
        viewControllers?[1].tabBarItem?.selectedImage = selectedimage2
        viewControllers?[1].tabBarItem?.image = normalimage2
        viewControllers?[3].tabBarItem?.selectedImage = selectedimage3
        viewControllers?[3].tabBarItem?.image = normalimage3
        viewControllers?[4].tabBarItem?.selectedImage = selectedimage4
        viewControllers?[4].tabBarItem?.image = normalimage4
        for vc in viewControllers!
        {
            vc.tabBarItem?.setTitlePositionAdjustment(UIOffset(horizontal: 0,vertical: 20))
        }
  

    }
    
    
    func addCenterButton()
    {
        let buttonimage = UIImage(named: "buttonplus") as UIImage?
        var centerButton = UIButton();
        centerButton.frame = CGRectMake(0,0,50,50);
        centerButton.setImage(buttonimage, forState:UIControlState.Normal);
        centerButton.center = self.tabBar.center;
        centerButton.addTarget(self,action:Selector("buttonTapped"),forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(centerButton);
        tabBar.frame = CGRectMake(tabBar.frame.origin.x,tabBar.frame.origin.y+0,tabBar.frame.width,tabBar.frame.height)
    }
    
    func buttonTapped()
    {
        presentNewVC()
    }
    
    func presentNewVC()
    {
        var storyBoard = UIStoryboard(name:"NewPublish",bundle:nil)
        var viewController = storyBoard.instantiateInitialViewController() as! UIViewController
        self.presentViewController(viewController,animated:true,completion:nil)
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

