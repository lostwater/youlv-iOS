//
//  EventsTableViewController.swift
//  Youlv
//
//  Created by Lost on 27/04/2015.
//  Copyright (c) 2015 Ramy. All rights reserved.
//

import UIKit

class MyEventsTableViewController: UITableViewController {
    

    
    var eventsArray : NSArray?
    
    var currentPage = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getMyEventsList(currentPage, pageSize: 10)
        
    }
    
    
    
    let client = DataClient()
    func getMyEventsList(currentPage: Int, pageSize:Int)
    {
        client.getMyEventsList(currentPage, pageSize: pageSize, completion: { (data, error) -> () in
            self.getMyEventsListCompleted(data, error: error)
        })
    }
    
    func getMyEventsListCompleted(data:NSData?,error:NSError?)
    {
        if error != nil
        {
            return
        }
        let errorPointer = NSErrorPointer()

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
    
    

    
}
