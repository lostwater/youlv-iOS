//
//  OpportunitiesBaseTableViewController.swift
//  Youlv
//
//  Created by Lost on 14/06/2015.
//  Copyright (c) 2015 Ramy. All rights reserved.
//



class OpportunitiesBaseTableViewController: UITableViewController {
    
    var ordersArray : NSArray?
    var currentPage = 1
    
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return ordersArray?.count ?? 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("OpportunityTableViewCell", forIndexPath: indexPath) as! OpportunityTableViewCell
        let content = ordersArray!.objectAtIndex(indexPath.row) as! NSDictionary
        cell.displayData(content)
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let text = (ordersArray!.objectAtIndex(indexPath.row) as! NSDictionary).objectForKey("order_content") as! String
        return calTextSizeWithDefualtFont(text,self.view.frame.size.width - 20).height+160.0
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
