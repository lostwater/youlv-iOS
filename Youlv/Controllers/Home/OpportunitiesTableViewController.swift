//
//  OpportunitiesTableViewController.swift
//  Youlv
//
//  Created by Lost on 27/04/2015.
//  Copyright (c) 2015 Ramy. All rights reserved.
//



import UIKit

class OpportunitiesTableViewController: OpportunitiesBaseTableViewController,NaviBarMenu {
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
        getOrderList(currentPage, pageSize: 10)
       
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        tabBarController?.navigationItem.title = "商机"
    }
    
    
    let client = DataClient()
    func getOrderList(currentPage: Int, pageSize:Int)
    {
        client.getOrderList(currentPage, pageSize: pageSize, completion: { (dict, error) -> () in
            self.getOrderListCompleted(dict, error: error)
        })
    }
    
    func getOrderListCompleted(dict:NSDictionary?,error:NSError?)
    {

        let dictData = dict!.objectForKey("data") as! NSDictionary
        ordersArray = (dictData.objectForKey("orderList") as? NSArray)!
        dispatch_sync(dispatch_get_main_queue(), { () -> Void in
                    self.tableView.reloadData()
        })
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "goOpportunityDetail"
        {
            let vc = segue.destinationViewController as! OpportunityDetailViewController
            let selectedIndex = tableView.indexPathForSelectedRow()?.item
            vc.dataDict = ordersArray!.objectAtIndex(selectedIndex!) as? NSDictionary
            vc.opportunityId = (ordersArray!.objectAtIndex(selectedIndex!) as! NSDictionary).objectForKey("order_id") as! Int
        }
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
