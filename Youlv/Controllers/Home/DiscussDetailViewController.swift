//
//  DiscussDetailViewController.swift
//  Youlv
//
//  Created by Lost on 12/05/2015.
//  Copyright (c) 2015 Ramy. All rights reserved.
//
import UIKit

class DiscussDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet var DiscussContentView: UIView!
    @IBOutlet var UserImageView: UIImageView!
    @IBOutlet var DiscussTitle: UILabel!
    @IBOutlet var DiscussTime: UILabel!
    @IBOutlet var DiscussTextView: UITextView!
    @IBOutlet var CommentView: UIView!
    @IBOutlet var ResponeButton: UIButton!
    @IBOutlet var FellowButton: UIButton!
    
    @IBOutlet var DiscussTextViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet var tableView: UITableView!
    
    @IBAction func sendAndUnwindFromReply(segue: UIStoryboardSegue)
    {
        getDiscussDetail()
    }
    
    @IBAction func followButtonClicked(sender: AnyObject) {
        if !FellowButton.selected
        {
            markTopic()
        }
    }
    
    
    var dataDict : NSDictionary?
    var topicId : Int?
    var isFromMyTopic = false
    var currentPage = 1
    
    override func viewDidLoad() {
        ResponeButton.setImage(UIImage(named:"buttonrespondlargeoutline"), forState: UIControlState.Normal)
        ResponeButton.setImage(UIImage(named:"buttonrespondlarge"), forState: UIControlState.Selected)
        FellowButton.setImage(UIImage(named:"buttonfollowlargeoutline"), forState:UIControlState.Normal)
        FellowButton.setImage(UIImage(named:"buttonfollowlarge"), forState:UIControlState.Selected)
        if isFromMyTopic
        {
            displayDataFromMyTopics()
        }
        else
        {
        
            displayData()
        }
        getDiscussDetail()

    }
    
    
   
    func markTopic()
    {
        var parameters : NSDictionary = ["topicId":topicId!, "sessionId":sessionId]
        DataClient().postMarkTopic(parameters) { (data, error) -> () in
            dispatch_sync(dispatch_get_main_queue(), { () -> Void in
                self.markTopicCompleted(data,error: error)
            })
        }
    }
    
    func markTopicCompleted(data:NSDictionary?,error:NSError?)
    {
        UIAlertView(title: data?.objectForKey("errmessage") as? String, message: nil, delegate: nil, cancelButtonTitle: "ok").show()
        if data!.objectForKey("errcode") as! Int == 0
        {
            FellowButton.selected = true
        }
    }

    
    func displayData()
    {
        UserImageView.sd_setImageWithURL(NSURL(string:self.dataDict!.objectForKey("topic_photoUrl") as! String))
        DiscussTitle.text = self.dataDict!.objectForKey("topic_title") as? String
        DiscussTime.text = self.dataDict!.objectForKey("operate_createDate") as? String
        DiscussTextView.text = self.dataDict!.objectForKey("topic_content") as? String
        resizeTextView()
        getDiscussDetail()
        
        let isMarked = self.dataDict!.objectForKey("topic_isPraise") as! Bool
        if isMarked
        {
            FellowButton.selected = true
        }
        else
        {
            FellowButton.selected = false
        }

    }
    
    func displayDataFromMyTopics()
    {
        var photoUrl = ""
        if self.dataDict!.objectForKey("reply_lawyerPhotoUrl") != nil
        {
            photoUrl = dataDict!.objectForKey("reply_lawyerPhotoUrl") as! String
        }
        if self.dataDict!.objectForKey("topic_lawyerPhotoUrl") != nil
        {
            photoUrl = dataDict!.objectForKey("topic_lawyerPhotoUrl") as! String

        }
        UserImageView.sd_setImageWithURL(NSURL(string: photoUrl))
        DiscussTitle.text = self.dataDict!.objectForKey("topic_lawyerName") as? String
        var date = ""
        if self.dataDict!.objectForKey("topic_createDate") != nil
        {
            date = dataDict!.objectForKey("topic_createDate") as! String
        }
        if self.dataDict!.objectForKey("reply_createDate") != nil
        {
            date = dataDict!.objectForKey("reply_createDate") as! String
            
        }
        
        DiscussTime.text = date
        DiscussTextView.text = self.dataDict!.objectForKey("topic_content") as? String
        resizeTextView()
        getDiscussDetail()
        
        let isMarked = true
        //let isMarked = self.dataDict!.objectForKey("topic_isPraise") as! Bool
        if isMarked
        {
            FellowButton.selected = true
        }
        else
        {
            FellowButton.selected = false
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "goDiscussReply"
        {
            let vc = segue.destinationViewController as! DiscussReplyViewController
            vc.topicId = self.topicId!
        }
    }
    
    
    
    var commentsArray = NSArray()
    func getDiscussDetail()
    {
        DataClient().getTopicDetail(topicId!, currentPage: currentPage, pageSize: 10) { (data, error) -> () in
            self.getDiscussDetailCompleted(data,error: error)
        }
    }
    

    func getDiscussDetailCompleted(data:NSData?,error:NSError?)
    {
        if error != nil
        {
            return
        }
        let errorPointer = NSErrorPointer()
        let dict = NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableLeaves, error: errorPointer) as! NSDictionary
        
        let dictData = dict.objectForKey("data") as! NSDictionary
        commentsArray = (dictData.objectForKey("replyList") as? NSArray)!
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self.tableView.reloadData()
        })

        
    }
    
    func resizeTextView() -> CGFloat
    {
   
        let textSize = DiscussTextView.text.sizeWithAttributes([NSFontAttributeName:UIFont.systemFontOfSize(14)])
        DiscussTextViewHeightConstraint.constant = textSize.height+8
        return textSize.height+8
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("DiscussCommentCell", forIndexPath: indexPath) as! DiscussCommentTableViewCell
        cell.displayData(commentsArray.objectAtIndex(indexPath.item) as! NSDictionary)
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commentsArray.count    }
    


    
  
    

    
    
    
}
