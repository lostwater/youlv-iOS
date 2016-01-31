//
//  TopicEventCell.swift
//  Youlv
//
//  Created by Lost on 25/01/2016.
//  Copyright © 2016 com.RamyTech. All rights reserved.
//

import Foundation
class TopicEventCell: UITableViewCell
{
    @IBOutlet var topicUserImageViewer: AvatarImageView?
    @IBOutlet var userImageView: AvatarImageView?
    @IBOutlet var topicUserName: UILabel?
    @IBOutlet var userName: UILabel?
    @IBOutlet var eventTitle: UILabel?
    @IBOutlet var eventTime: UILabel?
    @IBOutlet var bookMarkedButton: UIButton?
    @IBOutlet var likedButton: UIButton?
    @IBOutlet var topicText: UILabel?
    @IBOutlet var commentText: UILabel?
    @IBOutlet weak var topicTitle: UILabel?
    @IBOutlet weak var operateType: UILabel?
    
    @IBAction func bookMarkClicked(sender: AnyObject) {
        httpClient.topicEventUp(tag) { (dict, error) -> () in
            self.bookMarkedButton?.selected  = !self.bookMarkedButton!.selected
        }
        
    }
    
    var isAvatarPushEnabled = false
    var topicId = 0
    var topicEventId = 0
    
    func configure(dataDict : NSDictionary)
    {
        
        let userDict = dataDict.objectForKey("user") as! NSDictionary
        let topicDict = dataDict.objectForKey("topic") as! NSDictionary
        let topicTypeDict = topicDict.objectForKey("type") as! NSDictionary
        let topicUserDict = topicDict.objectForKey("user") as! NSDictionary
        
        tag = dataDict.objectForKey("topicevent_id") as! Int
        topicEventId = dataDict.objectForKey("topicevent_id") as! Int
        topicId = topicDict.objectForKey("topic_id") as! Int
        topicUserImageViewer?.isPushEnabled = isAvatarPushEnabled
        let type = dataDict.objectForKey("type") as! Int
        if type == 2
        {
            eventTitle?.text = "收藏了话题"
        }
        if type == 1
        {
            eventTitle?.text = "回应了话题"
        }
        if type == 0
        {
            eventTitle?.text = topicTypeDict.objectForKey("title") as? String
        }
        
        let topic_photoUrl = topicTypeDict.objectForKey("topictype_avatar_img") as! String
        let user_photoUrl = userDict.objectForKey("avatar") as! String
        
        topicUserImageViewer?.sd_setImageWithURL(NSURL(string: topic_photoUrl), placeholderImage: headImage)
        userImageView?.sd_setImageWithURL(NSURL(string: user_photoUrl), placeholderImage: headImage)
        
        topicUserImageViewer?.userId = topicUserDict.objectForKey("uid") as! Int
        topicUserImageViewer?.userDict = topicUserDict

        userImageView?.userId = userDict.objectForKey("uid") as! Int
        userImageView?.userDict = userDict
        
        topicUserName?.text = topicUserDict.objectForKey("name") as? String
        topicTitle?.text = topicTypeDict.objectForKey("title") as? String
        userName?.text = userDict.objectForKey("name") as? String
        
        let time = NSDate(fromString:dataDict.objectForKey("ctime") as! String)
        eventTime?.text = defaultDateFormatter.stringFromDate(time!)
        
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
            if isStore!
            {
                bookMarkedButton?.setTitle(String(storeCount! - 1), forState: UIControlState.Normal)
                bookMarkedButton?.setTitle(String(storeCount!), forState: UIControlState.Selected)
            }
            else
            {
                bookMarkedButton?.setTitle(String(storeCount!), forState: UIControlState.Normal)
                bookMarkedButton?.setTitle(String(storeCount! + 1), forState: UIControlState.Selected)
            }
        }
        if isStore != nil
        {
            bookMarkedButton?.selected = isStore!
        }
        
        topicText?.text = topicDict.objectForKey("text") as? String
        commentText?.text = dataDict.objectForKey("comment") as? String

    }
    

}
