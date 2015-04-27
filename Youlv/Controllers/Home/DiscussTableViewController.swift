//
//  DiscussTableViewController.swift
//  Youlv
//
//  Created by Lost on 27/04/2015.
//  Copyright (c) 2015 Ramy. All rights reserved.
//

import UIKit

class DiscussTableViewController: UITableViewController,NaviBarMenu {
    
    let menuWidth : CGFloat = 180
    let menuHeight : CGFloat = 212

    
    
    @IBOutlet var _naviMenuView: UIView!
    @IBOutlet var _titleButton: UIButton!
    var naviMenuView : UIView?
    var selectedTitle : String?
    var titleButton : UIButton?

    @IBOutlet weak var menuButton0: UIButton!
    @IBOutlet weak var menuButton1: UIButton!
    @IBOutlet weak var menuButton2: UIButton!
    @IBOutlet weak var menuButton3: UIButton!
    @IBOutlet weak var menuButton4: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        setNaviMenu()
        AddNaviMenuToHome()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    @IBAction func menuButtonClicked(sender: AnyObject) {
        setMenuTextAndHide(sender as! UIButton)
    }
    
    @IBAction func titleButtonClicked(sender: AnyObject) {
        showMenu()
    }
    
    
    func setButtonIconToRight(button : UIButton)
    {
        button.titleEdgeInsets = UIEdgeInsetsMake(0, -button.imageView!.frame.size.width,0,button.imageView!.frame.size.width)
        button.imageEdgeInsets = UIEdgeInsetsMake(0,button.titleLabel!.frame.size.width,0,-button.titleLabel!.frame.size.width)
    }
    
    func setMenuTextAndHide(selectedButton : UIButton)
    {
        menuButton0.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        menuButton1.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        menuButton2.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        menuButton3.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        menuButton4.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        selectedButton.setTitleColor(appBlueColor, forState: UIControlState.Normal)
        selectedTitle = selectedButton.titleForState(UIControlState.Normal)
        _titleButton.setTitle(selectedTitle, forState: UIControlState.Normal)
        setButtonIconToRight(_titleButton)
        _naviMenuView.hidden = true
    }
    
    
    func setMenuLoc()
    {
        _naviMenuView.frame = CGRectMake((view.frame.size.width - menuWidth)/2, 0, menuWidth, menuHeight)
        _naviMenuView.hidden = true
        _naviMenuView.layer.zPosition = CGFloat.max
    }
    
    
    func showMenu()
    {
        _naviMenuView.hidden = false
    }
    
    func setNaviMenu()
    {
        setMenuLoc()
        naviMenuView = _naviMenuView
        selectedTitle = menuButton0.titleForState(UIControlState.Normal)
        setMenuTextAndHide(menuButton0)
        
        titleButton = _titleButton
        setButtonIconToRight(titleButton!)
        titleButton?.setTitle(selectedTitle , forState: UIControlState.Normal)

    }
    
    func AddNaviMenuToHome()
    {
        if(appNaviMenuView != nil)
        {
            appNaviMenuView?.removeFromSuperview()
        }
        appNaviMenuView = naviMenuView
        
        self.tabBarController?.navigationItem.titleView = titleButton
        self.tabBarController?.view.addSubview(appNaviMenuView!)
    }
    
    
}
