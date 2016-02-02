//
//  GroupTopicsTableViewController.swift
//  Youlv
//
//  Created by Lost on 14/05/2015.
//  Copyright (c) 2015 Ramy. All rights reserved.
//

import UIKit

class GroupTopicsTableViewController: BaseTableViewController {

    @IBOutlet weak var topicImageView: UIImageView!
    @IBOutlet weak var userImageView: UIImageView!
    
    @IBOutlet weak var fansCount: UILabel!
    @IBOutlet weak var readCount: UILabel!
    @IBOutlet weak var repliedCount: UILabel!
    @IBOutlet weak var markButton: NSLayoutConstraint!
    
    @IBOutlet weak var groupTitle: UILabel!
    @IBOutlet weak var newReplyButton: UIButton!
    
    
    @IBOutlet weak var buttonFollow: UIButton!
    
    @IBAction func buttonFollowClicked(sender: AnyObject) {
        let groupId = groupDict.objectForKey("topictype_id") as! Int
        httpClient.topicGroupUp(groupId) { (dict, error) -> () in
            self.buttonFollow.selected = !self.buttonFollow.selected
        }
    }
    
    
    @IBAction func unwindToGroupTopics(segue: UIStoryboardSegue)
    {
        //performSegueWithIdentifier("UnwindToGroupTopics", sender: self)
    }
    
    
    var groupDict : NSDictionary!
    
    override func viewDidLoad() {
        
        
        
    }
    
    override func httpGet()
    {
        let groupId = groupDict.objectForKey("topictype_id") as! Int
        super.httpGet()
        httpClient.getTopicEventList(groupId) {(dict, error) -> () in
            self.httpGetCompleted(dict, error: error)
        }
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.destinationViewController.isKindOfClass(DiscussDetailViewController)
        {
            let discussDetail = segue.destinationViewController as! DiscussDetailViewController
            discussDetail.topicId = (tableView.cellForRowAtIndexPath(tableView.indexPathForSelectedRow!) as! TopicEventCell).topicId
            
        }
        
    }
    
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let content = dataArray.objectAtIndex(indexPath.row) as! NSDictionary
        var cell : TopicEventCell?
        if content.objectForKey("type") as! Int == 0
        {
            cell = tableView.dequeueReusableCellWithIdentifier("TopicCell", forIndexPath: indexPath) as? TopicEventCell
            
        }
            //if content.objectForKey("operate_type") as! Int == 1
        else
        {
            cell = tableView.dequeueReusableCellWithIdentifier("TopicRefCell", forIndexPath: indexPath) as? TopicEventCell
        }
        
        
        cell?.configure(content)
        cell?.setNeedsLayout()
        cell?.setNeedsDisplay()
        cell?.layoutIfNeeded()
        return cell!
    }
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.navigationBar.barTintColor = UIColor.clearColor()
        self.navigationController?.navigationBar.translucent = true
        navigationController?.navigationBar.setBackgroundImage(UIImage(named:"bgTransNavi"), forBarMetrics: UIBarMetrics.Default)
        
        super.viewDidLoad()
        userImageView.sd_setImageWithURL(NSURL(string : groupDict.objectForKey("topictype_avatar_img") as! String)!, placeholderImage:defualtPic)
        topicImageView.sd_setImageWithURL(NSURL(string : groupDict.objectForKey("topictype_background_img") as! String)!, placeholderImage:defualtPic)
        fansCount.text = String(groupDict.objectForKey("follow_num") as! Int)
        readCount.text = String(groupDict.objectForKey("read_num") as! Int)
        repliedCount.text = String(groupDict.objectForKey("topic_num") as! Int)
        groupTitle.text = groupDict.objectForKey("title") as? String
        
        buttonFollow.selected = groupDict.objectForKey("follow_or_not") as! Bool
        //let view = self.tableView.headerViewForSection(0)
        
        
        //view!.frame = CGRectMake(0,-44,view!.frame.size.width,view!.frame.size.height)
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.barTintColor = appBlueColor
        self.navigationController?.navigationBar.translucent = false
        navigationController?.navigationBar.setBackgroundImage(UIImage(named:"alpha0"), forBarMetrics: UIBarMetrics.Default)
        
    }


}
