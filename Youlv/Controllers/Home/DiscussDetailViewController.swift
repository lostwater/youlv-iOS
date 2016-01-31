//
//  DiscussDetailViewController.swift
//  Youlv
//
//  Created by Lost on 12/05/2015.
//  Copyright (c) 2015 Ramy. All rights reserved.
//
import UIKit

class DiscussDetailViewController: ViewControllerWithPagedTableView{
    @IBOutlet var DiscussContentView: UIView!
    @IBOutlet var UserImageView: UIImageView!
    @IBOutlet var DiscussTitle: UILabel!
    @IBOutlet var DiscussTime: UILabel!
    @IBOutlet var DiscussTextView: UILabel!
    @IBOutlet var CommentView: UIView!
    @IBOutlet var ResponeButton: UIButton!
    @IBOutlet var FellowButton: UIButton!
    
    @IBOutlet var DiscussTextViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet var tableView: UITableView!
    
    @IBAction func sendAndUnwindFromReply(segue: UIStoryboardSegue)
    {
       
    }
    
    @IBAction func followButtonClicked(sender: AnyObject) {
        if !FellowButton.selected
        {
            markTopic()
        }
    }
    
    var topicId : Int?
    var mainEventDict : NSDictionary?
    var isFromMyTopic = false

    override func viewDidLoad() {
        super.mainTableView = tableView
        //super.viewDidLoad()
        ResponeButton.setImage(UIImage(named:"buttonrespondlargeoutline"), forState: UIControlState.Normal)
        ResponeButton.setImage(UIImage(named:"buttonrespondlarge"), forState: UIControlState.Selected)
        FellowButton.setImage(UIImage(named:"buttonfollowlargeoutline"), forState:UIControlState.Normal)
        FellowButton.setImage(UIImage(named:"buttonfollowlarge"), forState:UIControlState.Selected)
    }
    
    override func httpGet()
    {
        super.httpGet()
        httpClient.getTopicDetail(topicId!) { (dict, error) -> () in
            self.httpGetCompleted(dict, error: error)
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        super.viewDidLoad()
    }
    
    override func httpGetCompleted(dict: NSDictionary?, error: NSError?) {
        nextUrl = dict?.objectForKey("next") as? String
        let array = dict!.objectForKey("results") as? NSArray
        
        mainEventDict = array!.filter( { (edict) -> Bool in
            return ((edict as! NSDictionary).objectForKey("type") as! Int) == 0
            }).first as? NSDictionary
        
        if mainEventDict != nil
        {
            displayTopic(mainEventDict)
        }
        
        let commentsArray = array!.filter( { (edict) -> Bool in
            return ((edict as! NSDictionary).objectForKey("type") as! Int) != 0
        }) as Array
        
        
        
        if (commentsArray.count ?? 0) > 0
        {
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.dataArray.addObjectsFromArray(commentsArray as Array)
                self.mainTableView?.reloadData()
                self.endLoad()
                self.mainTableView?.setNeedsLayout()
                self.mainTableView?.layoutIfNeeded()
                self.mainTableView?.reloadData()
                self.mainTableView?.beginUpdates()
                self.mainTableView?.endUpdates()
            })
            
        }
    }
    

    

    func markTopic()
    {
        let parameters : NSDictionary = ["topicId":topicId!, "sessionId":sessionId]
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
    
    func displayTopic(dict : NSDictionary?)
    {
        
        let userDict = dict?.objectForKey("user") as? NSDictionary
        let topicDict = dict?.objectForKey("topic") as? NSDictionary
        let typeDict = topicDict?.objectForKey("type") as? NSDictionary
        topicId = topicDict?.objectForKey("topic_id") as! Int
        UserImageView.sd_setImageWithURL(NSURL(string:userDict?.objectForKey("avatar") as! String),placeholderImage:headImage)
        DiscussTitle.text = typeDict?.objectForKey("title") as? String
        DiscussTime.text = defaultDateFormatter.stringFromDate(NSDate(fromString: dict?.objectForKey("ctime") as! String))
        DiscussTextView.text = topicDict?.objectForKey("text") as? String
        //resizeTextView()
        
        FellowButton.selected = dict?.objectForKey("up_or_not") as! Bool
    }

    
    func displayData(dict:NSDictionary)
    {
        

    }
    
    
//    func displayDataFromMyTopics()
//    {
//        var photoUrl = ""
//        if self.dataDict!.objectForKey("reply_lawyerPhotoUrl") != nil
//        {
//            photoUrl = dataDict!.objectForKey("reply_lawyerPhotoUrl") as! String
//        }
//        if self.dataDict!.objectForKey("topic_lawyerPhotoUrl") != nil
//        {
//            photoUrl = dataDict!.objectForKey("topic_lawyerPhotoUrl") as! String
//
//        }
//        UserImageView.sd_setImageWithURL(NSURL(string: photoUrl))
//        DiscussTitle.text = self.dataDict!.objectForKey("topic_lawyerName") as? String
//        var date = ""
//        if self.dataDict!.objectForKey("topic_createDate") != nil
//        {
//            date = dataDict!.objectForKey("topic_createDate") as! String
//        }
//        if self.dataDict!.objectForKey("reply_createDate") != nil
//        {
//            date = dataDict!.objectForKey("reply_createDate") as! String
//            
//        }
//        
//        DiscussTime.text = date
//        DiscussTextView.text = self.dataDict!.objectForKey("topic_content") as? String
//        resizeTextView()
//                
//        let isMarked = true
//        //let isMarked = self.dataDict!.objectForKey("topic_isPraise") as! Bool
//        if isMarked
//        {
//            FellowButton.selected = true
//        }
//        else
//        {
//            FellowButton.selected = false
//        }
//    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "goDiscussReply"
        {
            let vc = segue.destinationViewController as! DiscussReplyViewController
            vc.topicId = topicId!
        }
    }
    
    
    func resizeTextView() -> CGFloat
    {
   
        let textSize = DiscussTextView.text!.sizeWithAttributes([NSFontAttributeName:UIFont.systemFontOfSize(14)])
        DiscussTextViewHeightConstraint.constant = textSize.height+8
        return textSize.height+8
    }
    
    
    
   override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("DiscussCommentCell", forIndexPath: indexPath) as! DiscussCommentTableViewCell
        cell.configure(dataArray.objectAtIndex(indexPath.item) as! NSDictionary)
        return cell
    }

//
//    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
//
//        let content = dataArray.objectAtIndex(indexPath.item) as! NSDictionary
//        var commentString = content.objectForKey("content") as! String
//
//        var attCommentStr = NSAttributedString(string: commentString)
//        var range = NSMakeRange(0,attCommentStr.length)
//        var strDict = attCommentStr.attributesAtIndex(0, effectiveRange: &range)
//         var commentTextSize = calTextSizeWithDefualtFont(commentString, width: tableView.frame.width - 74)
//        return commentTextSize.height + 38
//    }
    
  
    

    
    
    
}
