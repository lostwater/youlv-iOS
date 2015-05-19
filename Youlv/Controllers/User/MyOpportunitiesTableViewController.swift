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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getMyPostOpportunities(currentPage, pageSize:10)
    }
    
    
    let client = DataClient()
    func getMyPostOpportunities(currentPage: Int, pageSize:Int)
    {
        client.getMyPostOpportunities(currentPage, pageSize: pageSize, completion: { (data, error) -> () in
            self.getMyPostOpportunitiesCompleted(data, error: error)
        })
    }
    
    func getMyPostOpportunitiesCompleted(data:NSData?,error:NSError?)
    {
        if error != nil
        {
            return
        }
        
        let errorPointer = NSErrorPointer()
        let dict = NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableLeaves, error: errorPointer) as? NSDictionary
        if dict == nil{
            return
        }
        let dictData = dict!.objectForKey("data") as! NSDictionary
        ordersArray = (dictData.objectForKey("orderList") as? NSArray)!
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
        let cell = tableView.dequeueReusableCellWithIdentifier("OpportunityTableViewCell", forIndexPath: indexPath) as! OpportunityTableViewCell
        let content = ordersArray!.objectAtIndex(indexPath.row) as! NSDictionary
        cell.displayData(content)
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let content = ordersArray!.objectAtIndex(indexPath.row) as! NSDictionary
        let contentText = content.objectForKey("order_content") as! NSString
        //let size = CGSizeMake(self.view.frame.size.width - 20, CGFloat.max)
        
        let attributes : Dictionary = [NSFontAttributeName:UIFont(name: "HelveticaNeue", size: 14)]
        let textSize = contentText.sizeWithAttributes([NSFontAttributeName:UIFont.systemFontOfSize(14)])
        
        return textSize.height+160
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "goOpportunityDetail"
        {
            let opportunityDetail = segue.destinationViewController as! OpportunityDetailViewController
            let selectedIndex = tableView.indexPathForSelectedRow()?.item
            opportunityDetail.dataDict = ordersArray!.objectAtIndex(selectedIndex!) as? NSDictionary
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
