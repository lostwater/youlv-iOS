//
//  MyGroupsTableViewController.swift
//  Youlv
//
//  Created by Lost on 25/07/2015.
//  Copyright (c) 2015 com.RamyTech. All rights reserved.
//

import UIKit

class MyGroupsTableViewController: BaseTableViewController {

    override func httpGet() {
        httpClient.getMyGroupList{(dict, error) -> () in
            self.httpGetCompleted(dict, error: error)
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("GroupCell", forIndexPath: indexPath) as! GroupCell
        cell.dict = dataArray.objectAtIndex(indexPath.item) as! NSDictionary
        cell.configure(dataArray.objectAtIndex(indexPath.item) as! NSDictionary)
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.destinationViewController.isKindOfClass(GroupDetailTableViewController)
        {
            let vc = segue.destinationViewController as! GroupDetailTableViewController
            let selectedIndex = tableView.indexPathForSelectedRow?.item
            vc.dict = dataArray[tableView.indexPathForSelectedRow!.item] as! NSDictionary
            
        }
        
    }
    
    
}
