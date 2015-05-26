		//
//  MainTabBarController.swift
//  Youlv
//
//  Created by Lost on 10/04/2015.
//  Copyright (c) 2015 Ramy. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    
    @IBOutlet var NewPubButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
         setTabBar()
        //setTabBar()
        
        // Do any additional setup after loading the view.
    }

    override func awakeFromNib() {
        setTabBarItems();
       
        addCenterButton();
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func setTabBarItems()
    {

        self.viewControllers?[0] = UIStoryboard(name:"Home",bundle:nil).instantiateInitialViewController() as! UIViewController;
        self.viewControllers?[1] = UIStoryboard(name:"Messages",bundle:nil).instantiateInitialViewController() as! UIViewController
        self.viewControllers?[3] = UIStoryboard(name:"Discovery",bundle:nil).instantiateInitialViewController() as! UIViewController
        self.viewControllers?[4]=UIStoryboard(name:"User",bundle:nil).instantiateInitialViewController() as! UIViewController
        
        
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
        viewControllers?[2].tabBarItem?.enabled = false;
        
  
    }
    
    func setTabBar()
    {
        tabBar.backgroundImage = UIImage()
        tabBar.shadowImage = UIImage()
        tabBar.barTintColor = UIColor.clearColor()
        
        var bgframe = CGRectMake(0, -10, tabBar.frame.size.width, 60)
        var bgView = UIView(frame: bgframe)
        bgView.backgroundColor = UIColor.groupTableViewBackgroundColor()
        //var blurView = DRNRealTimeBlurView(frame: bgframe)
        //view.addSubview(blurView)
        //tabBar.frame.origin = CGPointMake(25,5)
        tabBar.addSubview(bgView)
        
        //bgView.addSubview(tabBar)
        //view.addSubview(bgView)
        //blurView.addSubview(tabBar)
        
        //view.addSubview(bgIV)
    }

    
    func addCenterButton()
    {
        //let buttonimage = UIImage(named: "buttonplus") as UIImage?
        let centerButton = NewPubButton
        //var centerButton = UIButton();
        let x = self.view.frame.width/2 - 20
        centerButton.frame = CGRectMake(x,0,40,40);
        //centerButton.setImage(buttonimage, forState:UIControlState.Normal);
        //centerButton.center = self.tabBar.center;
        //centerButton.addTarget(self,action:Selector("buttonTapped"),forControlEvents: UIControlEvents.TouchUpInside)
        //	self.view.addSubview(centerButton);
        
        self.tabBar.addSubview(centerButton)
        tabBar.frame = CGRectMake(tabBar.frame.origin.x,tabBar.frame.origin.y+5,tabBar.frame.width,tabBar.frame.height)
    }
   
    func buttonTapped()
    {
        presentNewVC()
    }
    
    func presentNewVC()
    {
        
        var storyBoard = UIStoryboard(name:"NewPublish",bundle:nil)
        var newVC = storyBoard.instantiateInitialViewController() as! NewViewController
        
        //newVC.backGroundImageView.image = captureScreen()
        //let root = self.view.window!.rootViewController
        //root!.modalPresentationStyle = UIModalPresentationStyle.OverCurrentContext
        //root!.presentViewController(viewController, animated: true, completion: nil)
        //viewController.view.addSubview(<#view: UIView#>)
        
        self.presentViewController(newVC,animated:true,completion:nil)
    }
    
    func captureScreen()->UIImage
    {
        let window = UIApplication.sharedApplication().keyWindow
        let rect = window!.bounds
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        window?.layer.renderInContext(context)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img
    
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

