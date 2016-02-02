//
//  JoinGroupTableViewController.swift
//  Youlv
//
//  Created by Lost on 31/05/2015.
//  Copyright (c) 2015 Ramy. All rights reserved.
//


class JoinGroupTableViewController: BaseTableViewController {
    
     func getDataArray(currentPage: Int, pageSize: Int) {
        getGroupList(currentPage, pageSize:pageSize)

    }
    
    func getGroupList(currentPage: Int, pageSize:Int)
    {
        
    }
    
    func getGroupListCompleted(dict:NSDictionary?,error:NSError?)
    {
        let dictData = dict!.objectForKey("data") as! NSDictionary
        let array = dictData.objectForKey("groupList") as? NSArray
        if (array?.count ?? 0) > 0
        {
            dataArray.addObjectsFromArray(array! as Array)
           
            dispatch_sync(dispatch_get_main_queue(), { () -> Void in
                self.tableView.reloadData()
            })
            
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("groupCell", forIndexPath: indexPath) as! GroupTableViewCell
        cell.displayData(dataArray.objectAtIndex(indexPath.item) as! NSDictionary)
        return cell
        
    }

}
