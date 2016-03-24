//
//  GroupMembersTableViewController.swift
//  Youlv
//
//  Created by Lost on 04/02/2016.
//  Copyright © 2016 com.RamyTech. All rights reserved.
//


class GroupMembersTableViewController: UITableViewController {
    var ownerDict : NSDictionary?
    var membersArray : NSMutableArray?
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2;
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0
        {
            return 1
        }
        else
        {
            return membersArray?.count ?? 0
        }
        
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("UserCell", forIndexPath: indexPath)
        if indexPath.section == 0
        {
            cell.imageView?.sd_setImageWithURL(NSURL(string: ownerDict?.objectForKey("avatar") as! String)!, placeholderImage:  headImage)
            cell.textLabel?.text = ownerDict?.objectForKey("name") as? String
            cell.imageView?.layer.cornerRadius = (cell.imageView?.frame.size.height)!/2
            cell.imageView?.layer.masksToBounds = true
            return cell
        }
        else
        {
            let dict = membersArray![indexPath.item] as? NSDictionary
            cell.imageView?.sd_setImageWithURL(NSURL(string: dict?.objectForKey("avatar") as! String)!, placeholderImage:  headImage)
            cell.textLabel?.text = ownerDict?.objectForKey("name") as? String
            cell.imageView?.layer.cornerRadius = (cell.imageView?.frame.size.height)!/2
            cell.imageView?.layer.masksToBounds = true
            return cell
        }
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0
        {
            return "  群主"
        }
        return "  成员"
    }
    
    override func unwindForSegue(unwindSegue: UIStoryboardSegue, towardsViewController subsequentVC: UIViewController) {
        if unwindSegue.destinationViewController.isKindOfClass(GroupDetailTableViewController)
        {
            let vc = unwindSegue.destinationViewController as! GroupDetailTableViewController
            //vc.dict =
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.destinationViewController.isKindOfClass(UserHomeTableViewController)
        {
            let vc = segue.destinationViewController as! UserHomeTableViewController
            //let selectedIndex = tableView.indexPathForSelectedRow?.item
            let indexPath = tableView.indexPathForSelectedRow
            if indexPath?.section == 0
            {
                vc.userDict  = ownerDict
            }
            else
            {
                vc.userDict = membersArray![indexPath!.item] as? NSDictionary
            }
            
        }
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        if identifier == "GoUserHome"
        {
            var userDict : NSDictionary?
            let indexPath = tableView.indexPathForSelectedRow
            if indexPath?.section == 0
            {
                userDict  = ownerDict
            }
            else
            {
                userDict = membersArray![indexPath!.item] as? NSDictionary
            }
            if userDict?.objectForKey("uid") as! Int == myUserInfo?.objectForKey("uid") as! Int
            {
                return false
            }
            
        }
        return true
    }

}
