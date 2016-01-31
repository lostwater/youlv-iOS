//
//  TopicsTableViewController.swift
//  Youlv
//
//  Created by Lost on 22/04/2015.
//  Copyright (c) 2015 Ramy. All rights reserved.
//

import UIKit

class TopicsTableViewController: BaseTableViewController{
    
    var selectedGroupId = 0
    var selectedGroupName = "选择话题类型"
    
    override func httpGet() {
        super.httpGet()
        httpClient.getTopicList { (dict, error) -> () in
            self.httpGetCompleted(dict, error: error)
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let dict = dataArray.objectAtIndex(indexPath.row) as! NSDictionary
        let cell = tableView.dequeueReusableCellWithIdentifier("TopicCell", forIndexPath: indexPath) as UITableViewCell
        cell.textLabel?.text = dict.objectForKey("title") as? String
        cell.detailTextLabel?.text = dict.objectForKey("desc") as? String
        cell.tag = dict.objectForKey("topictype_id") as! Int
        cell.imageView?.sd_setImageWithURL(NSURL(string:dict.objectForKey("topictype_avatar_img") as! String)!, placeholderImage: headImage)
        return cell

    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "newTopicGroupDidSelected"
        {
            let i = tableView.indexPathForSelectedRow?.item
            let dict = dataArray.objectAtIndex(i!) as? NSDictionary
            selectedGroupId = dict?.objectForKey("topictype_id") as! Int
            selectedGroupName = dict?.objectForKey("title") as! String
            let vc = segue.destinationViewController as! NewTopicTableViewController
            vc.topicGroupId = selectedGroupId
            vc.selectedTopic.text = dict?.objectForKey("title") as? String
        }
        if segue.destinationViewController.isKindOfClass(GroupTopicsTableViewController)
        {
            let vc = segue.destinationViewController as! GroupTopicsTableViewController
            
            let i = tableView.indexPathForSelectedRow?.item
            let dict = dataArray.objectAtIndex(i!) as? NSDictionary
            selectedGroupId = dict?.objectForKey("topictype_id") as! Int
            vc.groupDict = dict!
        }
    }
}
