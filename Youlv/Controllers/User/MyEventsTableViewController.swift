//
//  EventsTableViewController.swift
//  Youlv
//
//  Created by Lost on 27/04/2015.
//  Copyright (c) 2015 Ramy. All rights reserved.
//

import UIKit

class MyEventsTableViewController: BaseTableViewController {

    override func httpGet() {
        super.httpGet()
        httpClient.getMyActivityList {(dict, error) -> () in
            self.httpGetCompleted(dict, error: error)
        }
        
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.destinationViewController.isKindOfClass(EventDetailViewController)
        {
            let eventDetail = segue.destinationViewController as! EventDetailViewController
            let selectedIndex = tableView.indexPathForSelectedRow?.item
            eventDetail.dict = dataArray.objectAtIndex(selectedIndex!) as? NSDictionary
            //eventDetail.eventId = Int(((dataArray.objectAtIndex(selectedIndex!).objectForKey("activeId") as? String))!)
        }
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("EventCell", forIndexPath: indexPath) as! EventTableViewCell
        cell.configure(dataArray.objectAtIndex(indexPath.item) as! NSDictionary)
        return cell
        
    }

}
