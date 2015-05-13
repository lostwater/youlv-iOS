    //
//  HomeViewController.swift
//  Youlv
//
//  Created by Lost on 12/04/2015.
//  Copyright (c) 2015 Ramy. All rights reserved.
//

import UIKit

   
    
class HomeTabBarController: TopTabBarController
{

    var naviMenuView : UIView?
    var isTabsSet = false
    
    override func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem!)
    {
        let i = item.tag
        setNaviMenu(viewControllers![i] as! NaviBarMenu)
    }
    
    func setNaviMenu(naviBarMenu : NaviBarMenu)
    {
        if((naviBarMenu.naviMenuView) != nil)
        {
            self.naviMenuView  = naviBarMenu.naviMenuView
            if(appNaviMenuView != nil)
            {
                appNaviMenuView?.removeFromSuperview()
            }
            appNaviMenuView = naviMenuView
            self.view.addSubview(appNaviMenuView!)
            self.navigationItem.titleView = naviBarMenu.titleButton
            naviBarMenu.titleButton!.setTitle(naviBarMenu.selectedTitle!, forState: UIControlState.Normal)
            setButtonIconToRight(naviBarMenu.titleButton!)
        }
    }
    
    func setButtonIconToRight(button : UIButton)
    {
        button.titleEdgeInsets = UIEdgeInsetsMake(0, -button.imageView!.frame.size.width,0,button.imageView!.frame.size.width)
        button.imageEdgeInsets = UIEdgeInsetsMake(0,button.titleLabel!.frame.size.width,0,-button.titleLabel!.frame.size.width)
    }
    
    override func awakeFromNib() {
        if !isTabsSet
        {
            setTabItems();
            isTabsSet = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func setTabItems()
    {
        
        let normalimages = [
            UIImage(named: "buttonopportunityblack") as UIImage?,
            UIImage(named: "buttondiscussblack") as UIImage?,
            UIImage(named: "buttoneventblack") as UIImage?,
            UIImage(named: "buttonreadblack") as UIImage?,
        
        ]
        let selectedimages = [
            UIImage(named: "buttonopportunityblue") as UIImage?,
            UIImage(named: "buttondiscussblue") as UIImage?,
            UIImage(named: "buttoneventblue") as UIImage?,
            UIImage(named: "buttonreadblue") as UIImage?
        ]
        for var i = 0; i < viewControllers!.count; ++i
        {
            var vc = viewControllers![i] as! UIViewController
            vc.tabBarItem?.image = normalimages[i]! as UIImage
            vc.tabBarItem?.selectedImage = selectedimages[i]! as UIImage
            vc.tabBarItem.title = ""            
        }
        
        //tabBar.frame = CGRectMake(tabBar.frame.origin.x,tabBar.frame.origin.y,
        //tabBar.frame.width,86)

    }
    
    func addCenterButton()
    {
        var centerButton = UIButton();
        centerButton.frame = CGRectMake(0,0,50,50);
        centerButton.backgroundColor = UIColor.blackColor();
        centerButton.setTitle("Add", forState: UIControlState.Normal);
        navigationItem.titleView=centerButton;
        self.tabBarController?.navigationItem.titleView = centerButton;
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
