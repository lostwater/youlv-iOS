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
    @IBOutlet var operatorTime: UILabel?
    @IBOutlet var bookMarkedButton: UIButton?
    @IBOutlet var likedButton: UIButton?
    @IBOutlet var topicTextView: UITextView?
    @IBOutlet var operatorTextView: UITextView?
    @IBOutlet weak var topicTitle: UILabel?
    @IBOutlet weak var operateType: UILabel?
    
    @IBOutlet var topicTextHeightConstraint: NSLayoutConstraint?
    @IBOutlet var operatorTextHeightConstraint: NSLayoutConstraint?
    
    var isAvatarPushEnabled = true
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func displayData(dataDict : NSDictionary)
    {
        let userDict = dataDict.objectForKey("user") as! NSDictionary
        let topicDict = dataDict.objectForKey("topic") as! NSDictionary
        let topicTypeDict = topicDict.objectForKey("type") as! NSDictionary
        let topicUserDict = topicDict.objectForKey("user") as! NSDictionary
        
        topicUserImageViewer?.isPushEnabled = isAvatarPushEnabled
        discussOperateType = DiscussOperateType(rawValue: dataDict.objectForKey("type") as! Int)
        if discussOperateType == DiscussOperateType.Bookmark
        {
            operateType?.text = "收藏了话题"
        }
        if discussOperateType == DiscussOperateType.Reply
        {
            operateType?.text = "回应了话题"
        }
        let topic_photoUrl = topicTypeDict.objectForKey("topictype_img") as! String
        let operate_photoUrl = userDict.objectForKey("avatar") as! String
        
        topicUserImageViewer?.sd_setImageWithURL(NSURL(string: topic_photoUrl), placeholderImage: headImage)
        operatorImageView?.sd_setImageWithURL(NSURL(string: operate_photoUrl), placeholderImage: headImage)
        
        topicUserImageViewer?.userId = topicUserDict.objectForKey("uid") as! Int
        operatorImageView?.userId = userDict.objectForKey("uid") as! Int

        topicUserName?.text = topicUserDict.objectForKey("name") as? String
        topicTitle?.text = topicDict.objectForKey("title") as? String
        operatorName?.text = userDict.objectForKey("name") as? String
        
        let time = NSDate(fromString:dataDict.objectForKey("ctime") as! String)
        operatorTime?.text = defaultDateFormatter.stringFromDate(time!)
        
        likedButton?.setTitle(String(dataDict.objectForKey("up_num") as! Int)
, forState: UIControlState.Normal)
        likedButton?.setTitle(String(dataDict.objectForKey("up_num") as! Int)
            , forState: UIControlState.Selected)
        likedButton?.setImage(UIImage(named: "iconfavorite"), forState: UIControlState.Selected)
        likedButton?.setImage(UIImage(named: "iconfavoriteoutline"), forState: UIControlState.Normal)
        likedButton?.selected = dataDict.objectForKey("up_or_not") as! Bool
        
        
        bookMarkedButton?.setImage(UIImage(named: "iconfavorite"), forState: UIControlState.Selected)
        bookMarkedButton?.setImage(UIImage(named: "iconfavoriteoutline"), forState: UIControlState.Normal)

        let storeCount = dataDict.objectForKey("up_num") as? Int
        let isStore = dataDict.objectForKey("up_or_not") as? Bool
        if storeCount != nil
        {
        bookMarkedButton?.setTitle(String(storeCount!)
            , forState: UIControlState.Normal)
        bookMarkedButton?.setTitle(String(storeCount!)
            , forState: UIControlState.Selected)
        }
        if isStore != nil
        {
            bookMarkedButton?.selected = isStore!
        }

        topicTextView?.text = topicDict.objectForKey("text") as? String
        operatorTextView?.text = dataDict.objectForKey("comment") as? String
        //resizeTextView(topicTextView)
        
        if operatorTextView != nil
        {
            //resizeTextView(operatorTextView!)

        }

    }
    
    
    func displayMyPost(dataDict : NSDictionary)
    {
        discussOperateType = DiscussOperateType.Post
        let topic_photoUrl = dataDict.objectForKey("topic_lawyerPhotoUrl") as! String

        topicUserImageViewer?.sd_setImageWithURL(NSURL(string: topic_photoUrl), placeholderImage: UIImage(named:"pichead"))
        topicUserImageViewer?.userId = dataDict.objectForKey("topic_lawyerId") as! Int
        operatorTime?.text = dataDict.objectForKey("topic_createDate") as? String
        topicUserName?.text = dataDict.objectForKey("topic_lawyerName") as? String

        bookMarkedButton?.setTitle(String(dataDict.objectForKey("topic_praiseCount") as! Int)
            , forState: UIControlState.Normal)
        bookMarkedButton?.setTitle(String(dataDict.objectForKey("topic_praiseCount") as! Int)
            , forState: UIControlState.Selected)
        bookMarkedButton?.setImage(UIImage(named: "iconfavorite"), forState: UIControlState.Selected)
        bookMarkedButton?.setImage(UIImage(named: "iconfavoriteoutline"), forState: UIControlState.Normal)
        //bookMarkedButton?.selected = dataDict.objectForKey("isStore") as! Bool

        //bookMarkedButton?.hidden = true
        topicTextView?.text = dataDict.objectForKey("topic_content") as? String

        resizeTextView(topicTextView!)
        
        if operatorTextView != nil
        {
            resizeTextView(operatorTextView!)
        }
        
    }
    
    
    func displayMyMarked(dataDict : NSDictionary)
    {
        discussOperateType = DiscussOperateType.Post
        let topic_photoUrl = dataDict.objectForKey("topic_lawyerPhotoUrl") as! String
        operatorTime?.text = dataDict.objectForKey("topic_createDate") as? String
        topicUserImageViewer?.sd_setImageWithURL(NSURL(string: topic_photoUrl), placeholderImage: UIImage(named:"pichead"))
        topicUserImageViewer?.userId = dataDict.objectForKey("topic_lawyerId") as! Int
        topicUserName?.text = dataDict.objectForKey("topic_lawyerName") as? String

        bookMarkedButton?.setTitle(String(dataDict.objectForKey("topic_praiseCount") as! Int)
            , forState: UIControlState.Normal)
        bookMarkedButton?.setTitle(String(dataDict.objectForKey("topic_praiseCount") as! Int)
            , forState: UIControlState.Selected)
        bookMarkedButton?.setImage(UIImage(named: "iconfavorite"), forState: UIControlState.Selected)
        bookMarkedButton?.setImage(UIImage(named: "iconfavoriteoutline"), forState: UIControlState.Normal)
        //bookMarkedButton?.selected = dataDict.objectForKey("isStore") as! Bool
        topicTextView?.text = dataDict.objectForKey("topic_content") as? String

        resizeTextView(topicTextView!)
        
        if operatorTextView != nil
        {
            resizeTextView(operatorTextView!)
        }
        
    }
    
    func displayMyReplied(dataDict : NSDictionary)
    {
        discussOperateType = DiscussOperateType.Post
        let operate_photoUrl = dataDict.objectForKey("reply_lawyerPhotoUrl") as! String
        operatorImageView?.sd_setImageWithURL(NSURL(string: operate_photoUrl), placeholderImage: UIImage(named:"pichead"))
        operatorImageView?.userId = dataDict.objectForKey("reply_lawyerId") as! Int
        operatorName?.text = dataDict.objectForKey("reply_lawyerName") as? String
        operatorTime?.text = dataDict.objectForKey("reply_createDate") as? String
        //bookMarkedButton?.hidden = true

        topicTextView?.text = dataDict.objectForKey("topic_content") as? String
        operatorTextView?.text = dataDict.objectForKey("reply_content") as? String
        resizeTextView(topicTextView!)
        
        if operatorTextView != nil
        {
            resizeTextView(operatorTextView!)
        }
        
    }
    
    func resetTextViewSize()
    {
        resizeTextView(topicTextView!)
        
        if operatorTextView != nil
        {
            resizeTextView(operatorTextView!)
        }

    }
}
