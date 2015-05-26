//
//  DiscussTableViewCell.swift
//  Youlv
//
//  Created by Lost on 11/05/2015.
//  Copyright (c) 2015 Ramy. All rights reserved.
//

import UIKit


enum DiscussOperateType: Int
{
    case Post = 0, Reply, Bookmark
}

class DiscussTableViewCell: UITableViewCell
{
    var discussOperateType : DiscussOperateType?

    @IBOutlet var topicUserImageViewer: AvatarImageView?
    @IBOutlet var operatorImageView: AvatarImageView?
    @IBOutlet var topicUserName: UILabel?
    @IBOutlet var operatorName: UILabel?
    @IBOutlet var operatorTime: UILabel!
    @IBOutlet var bookMarkedButton: UIButton!
    @IBOutlet var topicTextView: UITextView!
    @IBOutlet var operatorTextView: UITextView?
    @IBOutlet weak var topicTitle: UILabel?
    @IBOutlet weak var operateType: UILabel?
    
    @IBOutlet var topicTextHeightConstraint: NSLayoutConstraint!
    @IBOutlet var operatorTextHeightConstraint: NSLayoutConstraint?
    
    var dateFormatter = NSDateFormatter()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        dateFormatter.dateFormat="yyyy.MM.dd HH:mm"
        // Initialization code
    }
    
    func displayData(dataDict : NSDictionary)
    {
        discussOperateType = DiscussOperateType(rawValue: dataDict.objectForKey("operate_type") as! Int)
        if discussOperateType == DiscussOperateType.Bookmark
        {
            operateType?.text = "收藏了话题"
        }
        if discussOperateType == DiscussOperateType.Reply
        {
            operateType?.text = "回应了话题"
        }
        let topic_photoUrl = dataDict.objectForKey("topic_photoUrl") as! String
        let operate_photoUrl = dataDict.objectForKey("operate_photoUrl") as! String
        topicUserImageViewer?.sd_setImageWithURL(NSURL(string: topic_photoUrl), placeholderImage: headImage)
        operatorImageView?.sd_setImageWithURL(NSURL(string: operate_photoUrl), placeholderImage: headImage)
        topicUserImageViewer?.userId = dataDict.objectForKey("topic_lawyerId") as! Int
        let opId = dataDict.objectForKey("operate_lawyerId") as! Int
        operatorImageView?.userId = opId
        topicUserName?.text = dataDict.objectForKey("topic_lawyerName") as? String
        topicTitle?.text = dataDict.objectForKey("topic_title") as? String
        operatorName?.text = dataDict.objectForKey("operate__lawyerName") as? String
        let time = NSDate(fromString:dataDict.objectForKey("operate_createDate") as! String)
        operatorTime.text = dateFormatter.stringFromDate(time!)
        bookMarkedButton.setTitle(String(dataDict.objectForKey("topic_praiseCount") as! Int)
, forState: UIControlState.Normal)
        bookMarkedButton.setTitle(String(dataDict.objectForKey("topic_praiseCount") as! Int)
            , forState: UIControlState.Selected)
        bookMarkedButton.setImage(UIImage(named: "iconfavorite"), forState: UIControlState.Selected)
        bookMarkedButton.setImage(UIImage(named: "iconfavoriteoutline"), forState: UIControlState.Normal)
        let isMarked = dataDict.objectForKey("topic_isPraise") as! Bool
        if isMarked
        {
            bookMarkedButton.selected = true
        }
        else
        {
            bookMarkedButton.selected = false
        }
        topicTextView.text = dataDict.objectForKey("topic_content") as? String
        operatorTextView?.text = dataDict.objectForKey("operate_content") as? String
        resizeTextView(topicTextView)
        
        if operatorTextView != nil
        {
            resizeTextView(operatorTextView!)
            //if operatorTextView!.text == ""
            //{
            //    collapseView(operatorTextView!)
            //}
        }

    }
    
    
    func displayMyPost(dataDict : NSDictionary)
    {
        discussOperateType = DiscussOperateType.Post
        let topic_photoUrl = dataDict.objectForKey("topic_lawyerPhotoUrl") as! String

        topicUserImageViewer?.sd_setImageWithURL(NSURL(string: topic_photoUrl))
        operatorTime.text = dataDict.objectForKey("topic_createDate") as? String
        topicUserName?.text = dataDict.objectForKey("topic_lawyerName") as? String

        bookMarkedButton.setTitle(String(dataDict.objectForKey("topic_praiseCount") as! Int)
            , forState: UIControlState.Normal)
        bookMarkedButton.setTitle(String(dataDict.objectForKey("topic_praiseCount") as! Int)
            , forState: UIControlState.Selected)
        bookMarkedButton.setImage(UIImage(named: "iconfavorite"), forState: UIControlState.Selected)
        bookMarkedButton.setImage(UIImage(named: "iconfavoriteoutline"), forState: UIControlState.Normal)
        let isMarked = dataDict.objectForKey("topic_isPraise") as! Bool
        if isMarked
        {
            bookMarkedButton.selected = true
        }
        else
        {
            bookMarkedButton.selected = false
        }
        bookMarkedButton.hidden = true
        topicTextView.text = dataDict.objectForKey("topic_content") as? String

        resizeTextView(topicTextView)
        
        if operatorTextView != nil
        {
            resizeTextView(operatorTextView!)
        }
        
    }
    
    
    func displayMyMarked(dataDict : NSDictionary)
    {
        discussOperateType = DiscussOperateType.Post
        let topic_photoUrl = dataDict.objectForKey("topic_lawyerPhotoUrl") as! String
        operatorTime.text = dataDict.objectForKey("topic_createDate") as? String
        topicUserImageViewer?.sd_setImageWithURL(NSURL(string: topic_photoUrl))

        topicUserName?.text = dataDict.objectForKey("topic_lawyerName") as? String

        bookMarkedButton.setTitle(String(dataDict.objectForKey("topic_praiseCount") as! Int)
            , forState: UIControlState.Normal)
        bookMarkedButton.setTitle(String(dataDict.objectForKey("topic_praiseCount") as! Int)
            , forState: UIControlState.Selected)
        bookMarkedButton.setImage(UIImage(named: "iconfavorite"), forState: UIControlState.Selected)
        bookMarkedButton.setImage(UIImage(named: "iconfavoriteoutline"), forState: UIControlState.Normal)
        let isMarked = dataDict.objectForKey("topic_isPraise") as! Bool
        if isMarked
        {
            bookMarkedButton.selected = true
        }
        else
        {
            bookMarkedButton.selected = false
        }
        topicTextView.text = dataDict.objectForKey("topic_content") as? String

        resizeTextView(topicTextView)
        
        if operatorTextView != nil
        {
            resizeTextView(operatorTextView!)
        }
        
    }
    
    func displayMyReplied(dataDict : NSDictionary)
    {
        discussOperateType = DiscussOperateType.Post
        let operate_photoUrl = dataDict.objectForKey("reply_lawyerPhotoUrl") as! String
        operatorImageView?.sd_setImageWithURL(NSURL(string: operate_photoUrl))
        operatorName?.text = dataDict.objectForKey("reply_lawyerName") as? String
        operatorTime.text = dataDict.objectForKey("reply_createDate") as? String
        bookMarkedButton.hidden = true

        topicTextView.text = dataDict.objectForKey("topic_content") as? String
        operatorTextView?.text = dataDict.objectForKey("reply_content") as? String
        resizeTextView(topicTextView)
        
        if operatorTextView != nil
        {
            resizeTextView(operatorTextView!)
        }
        
    }
    
    func resetTextViewSize()
    {
        resizeTextView(topicTextView)
        
        if operatorTextView != nil
        {
            resizeTextView(operatorTextView!)
        }

    }
}
