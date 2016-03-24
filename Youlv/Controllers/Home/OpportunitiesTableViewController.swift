//
//  OpportunitiesTableViewController.swift
//  Youlv
//
//  Created by Lost on 27/04/2015.
//  Copyright (c) 2015 Ramy. All rights reserved.
//



import UIKit

class OpportunitiesTableViewController: BaseTableViewController,NaviBarMenu {
    let menuWidth : CGFloat = 180
    let menuHeight : CGFloat = 172
    
    @IBOutlet var _naviMenuView: UIView!
    @IBOutlet var _titleButton: UIButton!
    
    @IBOutlet weak var menuButton0: UIButton!
    @IBOutlet weak var menuButton1: UIButton!
    @IBOutlet weak var menuButton2: UIButton!
    @IBOutlet weak var menuButton3: UIButton!
    
    @IBAction func menuButtonClicked(sender: AnyObject) {
        setMenuTextAndHide(sender as! UIButton)
    }
    
    
    @IBAction func titleButtonClicked(sender: AnyObject) {
        showMenu(_naviMenuView)
    }
    
    var naviMenuView : UIView?
    var selectedTitle : String?
    var titleButton : UIButton?
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        //setNaviMenu()
        //AddNaviMenuToHome(naviMenuView!, titleButton!, self)

       
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        tabBarController?.navigationItem.title = "案源"
    }
    
    override func httpGet() {
        super.httpGet()
        httpClient.getCaseList{(dict, error) -> () in
            self.httpGetCompleted(dict, error: error)
        }
    }

    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.destinationViewController.isKindOfClass(OpportunityDetailViewController)
        {
            let vc = segue.destinationViewController as! OpportunityDetailViewController
            let selectedIndex = tableView.indexPathForSelectedRow?.item
            vc.dataDict = dataArray.objectAtIndex(selectedIndex!) as? NSDictionary

        }

    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell : OpportunityTableViewCell?
        if dataArray.count < (indexPath.row - 1)
        {
            return UITableViewCell()
        }
        let content = dataArray.objectAtIndex(indexPath.row) as! NSDictionary
        let type = content.objectForKey("type") as! Int
        if type < 3
        {
            cell = tableView.dequeueReusableCellWithIdentifier("CaseCell", forIndexPath: indexPath) as! OpportunityTableViewCell
        }
        else
        {
            cell = tableView.dequeueReusableCellWithIdentifier("InfoCell", forIndexPath: indexPath) as! OpportunityTableViewCell
        }
        cell!.configure(content)
        return cell!
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
