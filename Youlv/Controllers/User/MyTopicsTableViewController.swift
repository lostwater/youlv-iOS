//
//  DiscussTableViewController.swift
//  Youlv
//
//  Created by Lost on 27/04/2015.
//  Copyright (c) 2015 Ramy. All rights reserved.
//

import UIKit

class MyTopicsTableViewController: BaseTableViewController {
    
    @IBOutlet var typeSwitcher: UISegmentedControl!
    
    @IBAction func typeSwitcherChanged(sender: AnyObject) {
       //iniTableData()
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
            discussDetail.topicId = tableView.cellForRowAtIndexPath(tableView.indexPathForSelectedRow!)?.tag
            
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
      
    
    
}
