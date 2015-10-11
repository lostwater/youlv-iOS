//
//  UserHomeTableViewController.swift
//  Youlv
//
//  Created by Lost on 03/05/2015.
//  Copyright (c) 2015 Ramy. All rights reserved.
//

import UIKit

class UserHomeTableViewController: UITableViewController {

    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userIntroTextView: UITextView!
    @IBOutlet weak var userAdd: UILabel!
    @IBOutlet weak var buttonFellows: UIButton!
    @IBOutlet weak var buttonFans: UIButton!
    
    
    
    var topicsArray : NSArray?
    var currentPage = 1
    var userId = myLawyerId
    
    let client = DataClient()
    func getUserProfileWithTopicList(currentPage: Int, pageSize:Int)
    {
        client.getUserProfileWithTopicList(userId, currentPage: currentPage, pageSize: pageSize, completion: { (dict, error) -> () in
            self.getUserProfileWithTopicListCompleted(dict, error: error)
        })
    }
    
    func getUserProfileWithTopicListCompleted(dict:NSDictionary?,error:NSError?)
    {

        let dictData = dict!.objectForKey("data") as! NSDictionary
        topicsArray = (dictData.objectForKey("topicList") as? NSArray)!
        dispatch_sync(dispatch_get_main_queue(), { () -> Void in
            self.displayData(dictData)
            self.tableView.reloadData()
            
        })
        
    }
    
    func displayData(dataDict : NSDictionary)
    {
        userImageView.sd_setImageWithURL(NSURL(string: dataDict.objectForKey("lawyer_photoUrl") as! String),placeholderImage:headImage)
        userIntroTextView.text = dataDict.objectForKey("lawyer_introduction") as? String
        userIntroTextView.textColor = UIColor.whiteColor()
        userName.text =  dataDict.objectForKey("lawyer_introduction") as? String
        userAdd.text = (dataDict.objectForKey("lawyer_cityName") as! String) + ", " + (dataDict.objectForKey("lawyer_lawOffice") as! String)
        var fellowstitle = String(dataDict.objectForKey("lawyer_attentionCount")as! Int)
        fellowstitle = "关注 " + fellowstitle
        buttonFellows.setTitle(fellowstitle, forState: UIControlState.Normal)
        var fanstitle = String(dataDict.objectForKey("lawyer_fansCount")as! Int)
        fanstitle = "粉丝 " + fanstitle
        buttonFans.setTitle(fanstitle, forState: UIControlState.Normal)

    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        getUserProfileWithTopicList(currentPage, pageSize:10)
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
        return topicsArray?.count ?? 0
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
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let content = topicsArray!.objectAtIndex(indexPath.row) as! NSDictionary
        var cell : DiscussTableViewCell?
        if content.objectForKey("operate_type") as! Int == 0
        {
            cell = tableView.dequeueReusableCellWithIdentifier("DiscussPostedCell", forIndexPath: indexPath) as? DiscussTableViewCell
            
        }
            //if content.objectForKey("operate_type") as! Int == 1
        else
        {
            cell = tableView.dequeueReusableCellWithIdentifier("DiscussRepliedCell", forIndexPath: indexPath) as? DiscussTableViewCell
        }
        cell?.displayData(content)
        return cell!
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let content = topicsArray!.objectAtIndex(indexPath.row) as! NSDictionary
        if content.objectForKey("operate_type") as! Int == 0
        {
            let baseHeight :CGFloat = 115.0
            let topicContentText = content.objectForKey("topic_content") as! String
            let textHeight = calTextSizeWithDefualtFont(topicContentText, width: self.view.frame.width - 32).height
            
            return textHeight+baseHeight
            
        }
        else
        {
            let baseHeight :CGFloat = 115.0+95.0
            let topicContentText = content.objectForKey("topic_content") as! String
            let operatorContentText = content.objectForKey("operate_content") as! String
            var textHeight = calTextSizeWithDefualtFont(topicContentText, width: self.view.frame.width - 32).height
            textHeight = textHeight + calTextSizeWithDefualtFont(operatorContentText, self.view.frame.width - 32).height
            return textHeight+baseHeight
            
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
