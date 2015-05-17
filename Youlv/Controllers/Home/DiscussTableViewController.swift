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

    @IBOutlet weak var menuButtonUserHome: UIButton!
    @IBOutlet weak var menuButton0: UIButton!
    @IBOutlet weak var menuButton1: UIButton!
    @IBOutlet weak var menuButton2: UIButton!
    @IBOutlet weak var menuButton3: UIButton!

    var discussArray = NSArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNaviMenu()
        AddNaviMenuToHome(naviMenuView!, titleButton!, self)
        getDiscussList(1,pageSize: 10)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    
    let client = DataClient()
    func getDiscussList(currentPage: Int, pageSize:Int)
    {
        client.getDiscussList(currentPage, pageSize: pageSize, completion: { (data, error) -> () in
            self.getDiscussListCompleted(data, error: error)
        })
    }
    
    func getDiscussListCompleted(data:NSData?,error:NSError?)
    {
        if error != nil
        {
            return
        }
        
        let errorPointer = NSErrorPointer()
        let dict = NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableLeaves, error: errorPointer) as! NSDictionary
        
        let dictData = dict.objectForKey("data") as! NSDictionary
        discussArray = (dictData.objectForKey("discuessList") as? NSArray)!
        dispatch_sync(dispatch_get_main_queue(), { () -> Void in
            self.tableView.reloadData()
        })
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "goRepliedDiscussDetail" || segue.identifier == "goPostedDiscussDetail"
        {
            let discussDetail = segue.destinationViewController as! DiscussDetailViewController
            let selectedIndex = tableView.indexPathForSelectedRow()?.item
            discussDetail.setData((discussArray.objectAtIndex(selectedIndex!) as? NSDictionary)!)
        }
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        
        return discussArray.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let content = discussArray.objectAtIndex(indexPath.row) as! NSDictionary
        var cell : DiscussTableViewCell?
        if content.objectForKey("operate_type") as! Int == 0
        {
           cell = tableView.dequeueReusableCellWithIdentifier("DiscussPostedCell", forIndexPath: indexPath) as? DiscussTableViewCell

        }
            //if content.objectForKey("operate_type") as! Int == 1
        else
        {
            cell = tableView.dequeueReusableCellWithIdentifier("DiscussRepliedCell", forIndexPath: indexPath) as? DiscussTableViewCell
        }
        cell?.setData(content)
        return cell!
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let content = discussArray.objectAtIndex(indexPath.row) as! NSDictionary
        if content.objectForKey("operate_type") as! Int == 0
        {
            let topicContentText = content.objectForKey("topic_content") as! NSString
            let topicSize = CGSizeMake(self.view.frame.size.width - 16, CGFloat.max)
            let topicTextSize = topicContentText.sizeWithAttributes([NSFontAttributeName:UIFont.systemFontOfSize(14)])
            return topicTextSize.height+115
            
        }
            //if content.objectForKey("operate_type") as! Int == 1

        else
        {
            let topicContentText = content.objectForKey("topic_content") as! NSString
            let topicSize = CGSizeMake(self.view.frame.size.width - 16, CGFloat.max)
            let topicTextSize = topicContentText.sizeWithAttributes([NSFontAttributeName:UIFont.systemFontOfSize(14)])
            //return topicTextSize.height+95
            let operatorContentText = content.objectForKey("operate_content") as! NSString
            let operatorSize = CGSizeMake(self.view.frame.size.width - 32, CGFloat.max)
            let operatorTextSize = topicContentText.sizeWithAttributes([NSFontAttributeName:UIFont.systemFontOfSize(14)])
            return topicTextSize.height+115+operatorTextSize.height+37


        }
        
    }

    
    
    @IBAction func menuButtonUserHomeClicked(sender: AnyObject) {
        _naviMenuView.hidden = true

        let userHomeVC = UIStoryboard(name: "User", bundle: nil).instantiateViewControllerWithIdentifier("UserHomeVC") as! UIViewController
        navigationController?.pushViewController(userHomeVC, animated: true)
    }
    
    @IBAction func menuButtonClicked(sender: AnyObject) {
        setMenuTextAndHide(sender as! UIButton)
    }
    
    @IBAction func titleButtonClicked(sender: AnyObject) {
        showMenu(_naviMenuView)
    }
    
    
    func setMenuTextAndHide(selectedButton : UIButton)
    {
        menuButton0.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        menuButton1.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        menuButton2.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        menuButton3.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        selectedButton.setTitleColor(appBlueColor, forState: UIControlState.Normal)
        selectedTitle = selectedButton.titleForState(UIControlState.Normal)
        _titleButton.setTitle(selectedTitle, forState: UIControlState.Normal)
        setButtonIconToRight(_titleButton)
        _naviMenuView.hidden = true
    }
    
    
    func setNaviMenu()
    {
        setMenuLoc(_naviMenuView, view, menuWidth, menuHeight)
        
        naviMenuView = _naviMenuView
        selectedTitle = menuButton0.titleForState(UIControlState.Normal)
        setMenuTextAndHide(menuButton0)
        
        titleButton = _titleButton
        setButtonIconToRight(titleButton!)
        titleButton?.setTitle(selectedTitle , forState: UIControlState.Normal)
        
    }
    

    
    
}
