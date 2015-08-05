//
//  MyOpportunitiesTableViewController.swift
//  Youlv
//
//  Created by Lost on 21/04/2015.
//  Copyright (c) 2015 Ramy. All rights reserved.
//

import UIKit

class MyOpportunitiesTableViewController: UITableViewController {

    var ordersArray : NSArray?
    var currentPage = 1
    
    @IBOutlet weak var switcher: UISegmentedControl!
    
    @IBAction func switcherChanged(sender: AnyObject) {
        if switcher.selectedSegmentIndex == 0
        {
            currentPage = 1
            getMyPostOpportunities(currentPage, pageSize:10)
        }
        if switcher.selectedSegmentIndex == 1
        {
            currentPage = 1
            getMyRepiliedOpportunities(currentPage, pageSize:10)
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if switcher.selectedSegmentIndex == 0
        {
            currentPage = 1
            getMyPostOpportunities(currentPage, pageSize:10)
        }
        if switcher.selectedSegmentIndex == 1
        {
            currentPage = 1
            getMyRepiliedOpportunities(currentPage, pageSize:10)
        }
    }
    
    
    let client = DataClient()
    func getMyPostOpportunities(currentPage: Int, pageSize:Int)
    {
        client.getMyPostOpportunities(currentPage, pageSize: pageSize, completion: { (dict, error) -> () in
            self.getMyPostOpportunitiesCompleted(dict, error: error)
        })
    }
    
    func getMyPostOpportunitiesCompleted(dict:NSDictionary?,error:NSError?)
    {
        let dictData = dict!.objectForKey("data") as! NSDictionary
        ordersArray = (dictData.objectForKey("orderList") as? NSArray)!
        dispatch_sync(dispatch_get_main_queue(), { () -> Void in
            self.tableView.reloadData()
        })
    }
    
    func getMyRepiliedOpportunities(currentPage: Int, pageSize:Int)
    {
        client.getMyRepiliedOpportunities(currentPage, pageSize: pageSize, completion: { (dict, error) -> () in
            self.getMyRepiliedOpportunitiesCompleted(dict, error: error)
        })
    }

    func getMyRepiliedOpportunitiesCompleted(dict:NSDictionary?,error:NSError?)
    {
        ordersArray = dict!.objectForKey("data") as? NSArray
        //ordersArray = (dictData.objectForKey("orderList") as? NSArray)!
        dispatch_sync(dispatch_get_main_queue(), { () -> Void in
            self.tableView.reloadData()
        })
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        
        return ordersArray?.count ?? 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if switcher.selectedSegmentIndex == 0
        {
            let cell = tableView.dequeueReusableCellWithIdentifier("OpportunityTableViewCell", forIndexPath: indexPath) as! OpportunityTableViewCell
            let content = ordersArray!.objectAtIndex(indexPath.row) as! NSDictionary
            cell.displayData(content)
            return cell
        }
        else
        {
            let cell = tableView.dequeueReusableCellWithIdentifier("OpportunityReplyCell", forIndexPath: indexPath) as! OpportunityReplyTableViewCell
            let content = ordersArray!.objectAtIndex(indexPath.row) as! NSDictionary
            cell.displayData(content)
            return cell
        }
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if switcher.selectedSegmentIndex == 0
        {
            let content = ordersArray!.objectAtIndex(indexPath.row) as! NSDictionary
            var contentText = content.objectForKey("order_content") as? String
            let contentTextSize = calTextSizeWithDefaultSettings(contentText!)
            
            return contentTextSize.height + 160.0

        }
        else
        {
            let content = ordersArray!.objectAtIndex(indexPath.row) as! NSDictionary
            var opportunityText = content.objectForKey("orderContent") as? String
            let opportunityTextSize = calTextSizeWithDefaultSettings(opportunityText!)
            var replyText = content.objectForKey("replycontent") as? String
            let replyTextSize = calTextSizeWithDefaultSettings(opportunityText!)
            
            return opportunityTextSize.height + replyTextSize.height + 200.0
        }
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "goPostedOpportunityDetail"
        {
            let opportunityDetail = segue.destinationViewController as! OpportunityDetailViewController
            let selectedIndex = tableView.indexPathForSelectedRow()?.item
            opportunityDetail.dataDict = ordersArray!.objectAtIndex(selectedIndex!) as? NSDictionary
            opportunityDetail.opportunityId = opportunityDetail.dataDict?.objectForKey("order_id") as! Int
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

   

    func replaceNavTitle()
    {
        var typeSwitcher = UISegmentedControl();
        typeSwitcher.insertSegmentWithTitle("我发布的", atIndex: 0, animated: false)
        typeSwitcher.insertSegmentWithTitle("回应我的", atIndex: 1, animated: false)
        typeSwitcher.selectedSegmentIndex = 0
        self.navigationItem.titleView = typeSwitcher
    }

 

}
