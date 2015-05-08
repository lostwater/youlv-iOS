//
//  OpportunitiesTableViewController.swift
//  Youlv
//
//  Created by Lost on 27/04/2015.
//  Copyright (c) 2015 Ramy. All rights reserved.
//



import UIKit

class OpportunitiesTableViewController: UITableViewController,NaviBarMenu {
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
    
    var ordersArray = NSArray()

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //tableView.registerNib(UINib(nibName:"OpportunityTableViewCell", bundle: nil), forCellReuseIdentifier: "XibOpportunityTableViewCell")
        
        setNaviMenu()
        AddNaviMenuToHome(naviMenuView!, titleButton!, self)
        getOrderList(1, pageSize: 10)
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    
    
    
    let client = DataClient()
    func getOrderList(currentPage: Int, pageSize:Int)
    {
        client.getOrderList(currentPage, pageSize: pageSize, completion: { (data, error) -> () in
            self.getOrderListCompleted(data, error: error)
        })
    }
    
    func getOrderListCompleted(data:NSData?,error:NSError?)
    {
        if error != nil
        {
            return
        }
        
        let errorPointer = NSErrorPointer()
        let dict = NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableLeaves, error: errorPointer) as! NSDictionary
        
        let dictData = dict.objectForKey("data") as! NSDictionary
        ordersArray = (dictData.objectForKey("orderList") as? NSArray)!
        tableView.reloadData()
        
    }

    

    @IBOutlet var tableCell: OpportunityTableViewCell!
    
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
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
 
            return ordersArray.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("OpportunityTableViewCell", forIndexPath: indexPath) as! OpportunityTableViewCell
        let content = ordersArray.objectAtIndex(indexPath.row) as! NSDictionary
        let type = content.objectForKey("order_type") as! Int
        cell.setOpportunityType(OpportunityType(rawValue: type)!)
        cell.opportunityTitleLable.text = content.objectForKey("order_title") as? String
        cell.opportunityTextView.text = content.objectForKey("order_content") as! String
        cell.opportunityLocalButton.titleLabel?.text = content.objectForKey("order_cityName") as? String
        cell.opportunityValidUntilLable.text = content.objectForKey("order_deadDate") as? String
        cell.opportunityLikedButton.titleLabel?.text = String(content.objectForKey("order_interestCount") as! Int)
        cell.opportunityTextView.frame.size = CGSize(width:cell.opportunityTextView.frame.size.width, height:cell.opportunityTextView.contentSize.height)
        cell.frame.size = CGSize(width:cell.frame.size.width, height:cell.contentHeight)
        cell.userCreditRate = RSTapRateView(frame: cell.userCreditRate.frame)
        cell.userCreditRate.rating = 1
        cell.userCreditRate.layoutSubviews()
        //cell.addSubview(cell.userCreditRate)
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let content = ordersArray.objectAtIndex(indexPath.row) as! NSDictionary
        let contentText = content.objectForKey("order_content") as! NSString
        let size = CGSizeMake(self.view.frame.size.width - 20, CGFloat.max)
        
        let attributes : Dictionary = [NSFontAttributeName:UIFont(name: "HelveticaNeue", size: 14)]
        let textSize = contentText.sizeWithAttributes([NSFontAttributeName:UIFont.systemFontOfSize(14)])
        
        return textSize.height+160
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
    

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as! UITableViewCell

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
