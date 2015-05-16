//
//  JobsTableViewController.swift
//  Youlv
//
//  Created by Lost on 14/05/2015.
//  Copyright (c) 2015 Ramy. All rights reserved.
//

import UIKit

class JobsTableViewController: UITableViewController {
    
    var currentPage = 1
    var jobsArray : NSArray?
    
    let client = DataClient()
    func getJobList(currentPage: Int, pageSize:Int)
    {
        client.getJobList(currentPage, pageSize: pageSize, completion: { (data, error) -> () in
            self.getJobListCompleted(data, error: error)
        })
    }
    
    func getJobListCompleted(data:NSData?,error:NSError?)
    {
        if error != nil
        {
            return
        }
        
        let errorPointer = NSErrorPointer()
        let dict = NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableLeaves, error: errorPointer) as! NSDictionary
        
        let dictData = dict.objectForKey("data") as! NSDictionary
        jobsArray = (dictData.objectForKey("positionList") as? NSArray)!
        dispatch_sync(dispatch_get_main_queue(), { () -> Void in
            self.tableView.reloadData()
        })
        
    }
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        getJobList(1,pageSize: 10)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jobsArray?.count ?? 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("JobCell", forIndexPath: indexPath) as! JobTableViewCell
        cell.displayData(jobsArray?.objectAtIndex(indexPath.item) as! NSDictionary)
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "goJobDetail"
        {
            let vc = segue.destinationViewController as! JobDetailViewController
            let selectedIndex = tableView.indexPathForSelectedRow()?.item
            var selectedData = jobsArray?.objectAtIndex(selectedIndex!) as! NSDictionary
            vc.jobId = selectedData.objectForKey("position_id") as? Int
            vc.companyImageUrl = selectedData.objectForKey("position_officePhoto") as? String
        }
    }

    

}
