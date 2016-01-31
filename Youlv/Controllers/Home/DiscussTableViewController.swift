//
//  DiscussTableViewController.swift
//  Youlv
//
//  Created by Lost on 27/04/2015.
//  Copyright (c) 2015 Ramy. All rights reserved.
//

import UIKit

class DiscussTableViewController: BaseTableViewController,NaviBarMenu {
    
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

    override func viewDidLoad() {
        
      
        //setNaviMenu()
        //AddNaviMenuToHome(naviMenuView!, titleButton!, self)
        //getDiscussList(currentPage,pageSize: 10)

    }
    
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        tabBarController?.navigationItem.title = "讨论"
        
        super.viewDidLoad()
    }
   

    override func httpGet()
    {
        super.httpGet()
        httpClient.getTopicEventList {(dict, error) -> () in
            self.httpGetCompleted(dict, error: error)
        }
    }

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.destinationViewController.isKindOfClass(DiscussDetailViewController)
        {
            let discussDetail = segue.destinationViewController as! DiscussDetailViewController
            let dict = dataArray[tableView.indexPathForSelectedRow!.item] as! NSDictionary
            discussDetail.topicId = (dict.objectForKey("topic") as! NSDictionary).objectForKey("topic_id") as! Int
            
        }


    }
    

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let content = dataArray.objectAtIndex(indexPath.row) as! NSDictionary
                var cell : TopicEventCell?
                if content.objectForKey("type") as! Int == 0
                {
                   cell = tableView.dequeueReusableCellWithIdentifier("TopicCell", forIndexPath: indexPath) as? TopicEventCell
        
                }
                    //if content.objectForKey("operate_type") as! Int == 1
                else
                {
                    cell = tableView.dequeueReusableCellWithIdentifier("TopicRefCell", forIndexPath: indexPath) as? TopicEventCell
                }


        cell?.configure(content)
        cell?.setNeedsLayout()
        cell?.setNeedsDisplay()
        cell?.layoutIfNeeded()
        return cell!
    }
    

    
    
    @IBAction func menuButtonUserHomeClicked(sender: AnyObject) {
        _naviMenuView.hidden = true

        let userHomeVC = UIStoryboard(name: "User", bundle: nil).instantiateViewControllerWithIdentifier("UserHomeVC") 
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
        setMenuLoc(_naviMenuView, view: view, menuWidth: menuWidth, menuHeight: menuHeight)
        
        naviMenuView = _naviMenuView
        selectedTitle = menuButton0.titleForState(UIControlState.Normal)
        setMenuTextAndHide(menuButton0)
        
        titleButton = _titleButton
        setButtonIconToRight(titleButton!)
        titleButton?.setTitle(selectedTitle , forState: UIControlState.Normal)
        
    }
    

    
    
}
