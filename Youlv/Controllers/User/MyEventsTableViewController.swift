//
//  EventsTableViewController.swift
//  Youlv
//
//  Created by Lost on 27/04/2015.
//  Copyright (c) 2015 Ramy. All rights reserved.
//

import UIKit

class MyEventsTableViewController: BaseTableViewController {
    override func awakeFromNib() {
        httpGet = getEventList
    }
    

    func getEventList(currentPage: Int, pageSize:Int)
    {
        DataClient().getEventList(currentPage, pageSize: pageSize, completion: { (dict, error) -> () in
            self.getEventListCompleted(dict, error: error)
        })
    }

    
    func getEventListCompleted(dict:NSDictionary?,error:NSError?)
    {
        let dictData = dict!.objectForKey("data") as! NSDictionary
        let array = dictData.objectForKey("activeList") as? NSArray
        if (array?.count ?? 0) > 0
        {
            dataArray.addObjectsFromArray(array! as Array)
            currentPage++
            dispatch_sync(dispatch_get_main_queue(), { () -> Void in
                self.tableView.reloadData()
                self.tableView.headerEndRefreshing()
                self.tableView.footerEndRefreshing()

            })
            
            
        }
        
    }
    
    var eventsArray : NSArray?
    
    
    
    
    let client = DataClient()
    func getMyEventsList(currentPage: Int, pageSize:Int)
    {
        client.getMyEventsList(currentPage, pageSize: pageSize, completion: { (dict, error) -> () in
            self.getMyEventsListCompleted(dict, error: error)
        })
    }
    
    func getMyEventsListCompleted(dict:NSDictionary?,error:NSError?)
    {
        
        let dictData = dict!.objectForKey("data") as! NSDictionary
        eventsArray = (dictData.objectForKey("activeList") as? NSArray)!
        dispatch_sync(dispatch_get_main_queue(), { () -> Void in
            self.tableView.reloadData()
        })
        
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "goEventDetail"
        {
            let eventDetail = segue.destinationViewController as! EventDetailViewController
            let selectedIndex = tableView.indexPathForSelectedRow?.item
            _ = dataArray.objectAtIndex(selectedIndex!) as! NSDictionary
            eventDetail.eventId = Int(((dataArray.objectAtIndex(selectedIndex!).objectForKey("activeId") as? String))!)
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
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("EventCell", forIndexPath: indexPath) as! EventTableViewCell
        cell.displayData(dataArray.objectAtIndex(indexPath.item) as! NSDictionary)
        return cell
        
    }
    
    

    
}
