//
//  UserHomeTableViewController.swift
//  Youlv
//
//  Created by Lost on 03/05/2015.
//  Copyright (c) 2015 Ramy. All rights reserved.
//

import UIKit

class UserHomeTableViewController: BaseTableViewController {

    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var userImageView: AvatarImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userIntroTextView: UITextView!
    @IBOutlet weak var userAdd: UILabel!
    @IBOutlet weak var buttonFellows: UIButton!
    @IBOutlet weak var buttonFans: UIButton!
    
    var userId = 0
    var userDict : NSDictionary?
    
    override func viewDidLoad() {
        super.viewDidLoad()
               
    }
    
    override func httpGet()
    {
            }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        displayData()
        super.httpGet()
        httpClient.getUserTopicEvents(userId, completion: { (dict, error) -> () in
            self.httpGetCompleted(dict, error: error)
        })

    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.destinationViewController.isKindOfClass(DiscussDetailViewController)
        {
            let discussDetail = segue.destinationViewController as! DiscussDetailViewController
            discussDetail.topicId = tableView.cellForRowAtIndexPath(tableView.indexPathForSelectedRow!)?.tag
            
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
    

    
    func displayData()
    {
        userImageView.sd_setImageWithURL(NSURL(string: userDict?.objectForKey("avatar") as! String),placeholderImage:headImage)
        userIntroTextView.text = userDict?.objectForKey("about") as? String
        userIntroTextView.textColor = UIColor.whiteColor()
        userName.text =  userDict?.objectForKey("name") as? String
        userAdd.text = (userDict?.objectForKey("location") as! String) + ", " + (userDict?.objectForKey("agency") as! String)
        var fellowstitle = String(userDict?.objectForKey("follow_num")as! Int)
        fellowstitle = "关注 " + fellowstitle
        buttonFellows.setTitle(fellowstitle, forState: UIControlState.Normal)
        var fanstitle = String(userDict?.objectForKey("followed_num")as! Int)
        fanstitle = "粉丝 " + fanstitle
        buttonFans.setTitle(fanstitle, forState: UIControlState.Normal)

    }

    

    override func tableView(tableView: UITableView, didEndDisplayingCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if(self.tableView.contentOffset.y > 0)
        {
            UIView.animateWithDuration(0.5, animations: { () -> Void in
                self.shortHeader()
            })
        }
        else
        {
            UIView.animateWithDuration(0.5, animations: { () -> Void in
                self.fullHeader()
            })
        }
        
    }
    
    

   
    
    func fullHeader()
    {
        headerView.frame = CGRectMake(headerView.frame.origin.x,
            headerView.frame.origin.y,
            headerView.frame.size.width,
            385
        )
        
        buttonFellows.hidden = false
        buttonFans.hidden = false
        userIntroTextView.frame.size = CGSize(width: userIntroTextView.frame.size.width, height: 0)
        userIntroTextView.hidden = false
        userImageView.frame.size = CGSize(width: 80, height: 80)
    }
    
    func shortHeader()
    {
        headerView.frame = CGRectMake(headerView.frame.origin.x,
            headerView.frame.origin.y,
            headerView.frame.size.width,
            180
        )
        buttonFellows.hidden = true
        buttonFans.hidden = true
        userIntroTextView.frame.size = CGSize(width: userIntroTextView.frame.size.width, height: 95)
        userIntroTextView.hidden = true
        userImageView.frame.size = CGSize(width: 50, height: 50)

    }

   

}
