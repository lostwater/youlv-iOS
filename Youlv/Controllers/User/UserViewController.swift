//
//  UserHomeTableViewController.swift
//  Youlv
//
//  Created by Lost on 03/05/2015.
//  Copyright (c) 2015 Ramy. All rights reserved.
//

import UIKit

class UserViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userIntroTextView: UITextView!
    @IBOutlet weak var userAdd: UILabel!
    @IBOutlet weak var buttonFellows: UIButton!
    @IBOutlet weak var buttonFans: UIButton!
    @IBOutlet weak var buttonChat: UIButton?
    @IBOutlet weak var buttonFollow: UIButton?
    @IBOutlet weak var tableView : UITableView!
    
    @IBAction func buttonFollowClicked(sender: AnyObject) {
    }
    @IBAction func buttonShareClicked(sender: AnyObject) {
    }
    
    @IBOutlet weak var imageWidth: NSLayoutConstraint!
    @IBOutlet weak var imageHeight: NSLayoutConstraint!
    @IBOutlet weak var fansCountHeight: NSLayoutConstraint!
    @IBOutlet weak var fellowsCountHeight: NSLayoutConstraint!
    @IBOutlet weak var introTextViewHeight: NSLayoutConstraint!
    
    
    
    
    var topicsArray : NSArray?
    var currentPage = 1
    var userId = myLawyerId
    var phone : String?
    
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
        
        userImageView.sd_setImageWithURL(NSURL(string: dataDict.objectForKey("lawyer_photoUrl") as! String), placeholderImage: headImage)
        userIntroTextView.text = dataDict.objectForKey("lawyer_introduction") as? String
   
        userName.text =  dataDict.objectForKey("lawyer_name") as? String
        userAdd.text = (dataDict.objectForKey("lawyer_cityName") as! String) + ", " + (dataDict.objectForKey("lawyer_lawOffice") as! String)
        var fellowstitle = String(dataDict.objectForKey("lawyer_attentionCount")as! Int)
        fellowstitle = "关注 " + fellowstitle
        buttonFellows.setTitle(fellowstitle, forState: UIControlState.Normal)
        var fanstitle = String(dataDict.objectForKey("lawyer_fansCount")as! Int)
        fanstitle = "粉丝 " + fanstitle
        buttonFans.setTitle(fanstitle, forState: UIControlState.Normal)
        
        userIntroTextView.textAlignment = NSTextAlignment.Center
        userIntroTextView.textColor = UIColor.whiteColor()
        
        phone =  dataDict.objectForKey("phone") as? String
        
        fullHeader()
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "goPersonalChatVC"
        {
            let vc = segue.destinationViewController as! PrivateChatViewController
            vc.userPhone = phone!
            //vc.chattitle = userName.text
        }

    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        hidesBottomBarWhenPushed = true
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userIntroTextView.textAlignment = NSTextAlignment.Center
        userIntroTextView.textColor = UIColor.whiteColor()
        getUserProfileWithTopicList(currentPage, pageSize:10)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // MARK: - Table view data source
    
     func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
     func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topicsArray?.count ?? 0
    }
    
    
     func tableView(tableView: UITableView, didEndDisplayingCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        let y = self.tableView.contentOffset.y
        if(self.tableView.contentOffset.y > firstCellHeight())
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
    
    
     func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
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
        cell?.isAvatarPushEnabled = false
        cell?.displayData(content)
        return cell!
    }
    
     func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let content = topicsArray!.objectAtIndex(indexPath.row) as! NSDictionary
        if content.objectForKey("operate_type") as! Int == 0
        {
            let baseHeight :CGFloat = 115.0
            let topicContentText = content.objectForKey("topic_content") as! String
            let textHeight = calTextSizeWithDefualtFont(topicContentText, self.view.frame.width - 32).height
            
            return textHeight+baseHeight
            
        }
        else
        {
            let baseHeight :CGFloat = 115.0+95.0
            let topicContentText = content.objectForKey("topic_content") as! String
            let operatorContentText = content.objectForKey("operate_content") as! String
            var textHeight = calTextSizeWithDefualtFont(topicContentText, self.view.frame.width - 32).height
            textHeight = textHeight + calTextSizeWithDefualtFont(operatorContentText, self.view.frame.width - 32).height
            return textHeight+baseHeight
            
        }
        
    }
    
    func firstCellHeight() -> CGFloat
    {
        if topicsArray?.count ?? 0 == 0
        {
            return 0
        }
        let content = topicsArray!.objectAtIndex(0) as! NSDictionary
        if content.objectForKey("operate_type") as! Int == 0
        {
            let baseHeight :CGFloat = 115.0
            let topicContentText = content.objectForKey("topic_content") as! String
            let textHeight = calTextSizeWithDefualtFont(topicContentText, self.view.frame.width - 32).height
            
            return textHeight+baseHeight
            
        }
        else
        {
            let baseHeight :CGFloat = 115.0+95.0
            let topicContentText = content.objectForKey("topic_content") as! String
            let operatorContentText = content.objectForKey("operate_content") as! String
            var textHeight = calTextSizeWithDefualtFont(topicContentText, self.view.frame.width - 32).height
            textHeight = textHeight + calTextSizeWithDefualtFont(operatorContentText, self.view.frame.width - 32).height
            return textHeight+baseHeight
            
        }
    }
    
    func fullHeader()
    {
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(0.3)
        imageWidth.constant = 80
        imageHeight.constant = 80
        fansCountHeight.constant = 50
        fellowsCountHeight.constant = 50
        resizeTextView(userIntroTextView)
        buttonFellows.hidden = false
        buttonFans.hidden = false
        UIView.commitAnimations()
        
        
    }
    
    func shortHeader()
    {
        
         let context = UIGraphicsGetCurrentContext()
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(0.3)
        imageWidth.constant = 50
        imageHeight.constant = 50
        fansCountHeight.constant = 0
        fellowsCountHeight.constant = 0
        introTextViewHeight.constant = 0
        buttonFellows.hidden = true
        buttonFans.hidden = true
        UIView.commitAnimations()
    }
    
    
    
}
