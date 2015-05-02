//
//  Helper.swift
//  Youlv
//
//  Created by Lost on 28/04/2015.
//  Copyright (c) 2015 Ramy. All rights reserved.
//

import Foundation

func setButtonIconToRight(button : UIButton)
{
    button.titleEdgeInsets = UIEdgeInsetsMake(0, -button.imageView!.frame.size.width,0,button.imageView!.frame.size.width)
    button.imageEdgeInsets = UIEdgeInsetsMake(0,button.titleLabel!.frame.size.width,0,-button.titleLabel!.frame.size.width)
}


func setMenuLoc(_naviMenuView : UIView, view : UIView, menuWidth : CGFloat, menuHeight : CGFloat)
{
    _naviMenuView.frame = CGRectMake((view.frame.size.width - menuWidth)/2, 0, menuWidth, menuHeight)
    _naviMenuView.hidden = true
    _naviMenuView.layer.zPosition = CGFloat(FLT_MAX)}


func showMenu(_naviMenuView : UIView)
{
    _naviMenuView.hidden = false
}



func AddNaviMenuToHome(naviMenuView : UIView, titleButton : UIButton, tabBarChildViewController : UIViewController)
{
    if(appNaviMenuView != nil)
    {
        appNaviMenuView?.removeFromSuperview()
    }
    appNaviMenuView = naviMenuView
    
    tabBarChildViewController.tabBarController?.navigationItem.titleView = titleButton
    tabBarChildViewController.tabBarController?.view.addSubview(appNaviMenuView!)
}