//
//  JoinGroupTableViewController.swift
//  Youlv
//
//  Created by Lost on 31/05/2015.
//  Copyright (c) 2015 Ramy. All rights reserved.
//


class JoinGroupTableViewController: BaseTableViewController {
    
    override func httpGet() {
        httpClient.getGroupList{(dict, error) -> () in
            
            let mdict = NSMutableDictionary(dictionary: dict!)
            let marray = NSMutableArray(array: (dict!.objectForKey("results") as! NSArray))
            let removeArray = NSMutableArray()
   
            marray.forEach({ (g) -> () in
                if groupList!.contains({ (mygroup) -> Bool in
                    mygroup.objectForKey("group_id") as! Int == g.objectForKey("group_id") as! Int})
                {
                    marray.removeObject(g)
                }
                }
                )
            mdict.setValue(marray, forKey: "results")
            
            self.httpGetCompleted(mdict, error: error)
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
