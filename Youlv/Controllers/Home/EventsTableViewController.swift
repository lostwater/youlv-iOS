//
//  EventsTableViewController.swift
//  Youlv
//
//  Created by Lost on 27/04/2015.
//  Copyright (c) 2015 Ramy. All rights reserved.
//

import UIKit

class EventsTableViewController: UITableViewController,NaviBarMenu {
    
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
    
    var eventsArray : NSArray?
    
    var currentPage = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //setNaviMenu()
        //AddNaviMenuToHome(naviMenuView!, titleButton!, self)
        getEventList(currentPage, pageSize: 10)

    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        tabBarController?.navigationItem.title = "活动"
    }
    
    let client = DataClient()
    func getEventList(currentPage: Int, pageSize:Int)
    {
        client.getEventList(currentPage, pageSize: pageSize, completion: { (data, error) -> () in
            self.getEventListCompleted(data, error: error)
        })
    }
    
    func getEventListCompleted(data:NSData?,error:NSError?)
    {
        if error != nil
        {
            return
        }
        let errorPointer = NSErrorPointer()
        let ds = NSString(data: data!, encoding: NSUTF8StringEncoding) as! String
        //print(NSJSONSerialization.isValidJSONObject(data!))
        NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableLeaves, error: errorPointer)
        print(errorPointer.debugDescription)
        let dict = NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableLeaves, error: errorPointer) as! NSDictionary

        let dictData = dict.objectForKey("data") as! NSDictionary
        eventsArray = (dictData.objectForKey("activeList") as? NSArray)!
        dispatch_sync(dispatch_get_main_queue(), { () -> Void in
            self.tableView.reloadData()
        })
        
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "goEventDetail"
        {
            let eventDetail = segue.destinationViewController as! EventDetailViewController
            let selectedIndex = tableView.indexPathForSelectedRow()?.item
            var selectedData = eventsArray!.objectAtIndex(selectedIndex!) as! NSDictionary
            eventDetail.eventId = (eventsArray!.objectAtIndex(selectedIndex!).objectForKey("activeId") as? String)?.toInt()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return eventsArray?.count ?? 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("EventCell", forIndexPath: indexPath) as! EventTableViewCell
        cell.displayData(eventsArray!.objectAtIndex(indexPath.item) as! NSDictionary)
        return cell

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
