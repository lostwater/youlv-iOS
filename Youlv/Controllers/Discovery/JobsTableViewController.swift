//
//  JobsTableViewController.swift
//  Youlv
//
//  Created by Lost on 14/05/2015.
//  Copyright (c) 2015 Ramy. All rights reserved.
//

import UIKit

class JobsTableViewController: BaseTableViewController {
    
    override func httpGet() {
        super.httpGet()
        httpClient.getJobList {(dict, error) -> () in
            self.httpGetCompleted(dict, error: error)
        }

    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("JobCell", forIndexPath: indexPath) as! JobTableViewCell
        cell.configure(dataArray.objectAtIndex(indexPath.item) as! NSDictionary)
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "goJobDetail"
        {
            let vc = segue.destinationViewController as! JobDetailViewController
            let selectedIndex = tableView.indexPathForSelectedRow?.item
            let selectedData = dataArray.objectAtIndex(selectedIndex!) as! NSDictionary
            vc.dataDict  = selectedData
        }
    }

    

}
