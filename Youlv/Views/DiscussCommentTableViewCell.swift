
//
//  DiscussCommentTableViewCell.swift
//  Youlv
//
//  Created by Lost on 12/05/2015.
//  Copyright (c) 2015 Ramy. All rights reserved.
//


import UIKit


class DiscussCommentTableViewCell: UITableViewCell {

    @IBOutlet var UserImageView: UIImageView!
    @IBOutlet var UserName: UILabel!
    @IBOutlet var CommentContent: UILabel!
    @IBOutlet var CommentTime: UILabel!
    @IBOutlet var LikedButton: UIButton!
    
    @IBAction func likedButtonClicked(sender: AnyObject) {
        if !LikedButton.selected
        {
            likeReply()
        }
    }

    
    override func awakeFromNib() {
        LikedButton.setImage(UIImage(named:"buttonlikecommentgrey"), forState: UIControlState.Normal)
        LikedButton.setImage(UIImage(named:"buttonlikecommentblue"), forState: UIControlState.Selected)
    }
    
    func displayData(dataDict : NSDictionary)
    {
        self.tag = dataDict.objectForKey("id") as! Int
        UserImageView.sd_setImageWithURL(NSURL(string: dataDict.objectForKey("photoUrl") as! String))
        UserName.text = dataDict.objectForKey("lawyerName") as? String
        CommentContent.text = dataDict.objectForKey("content") as? String
        CommentTime.text = dataDict.objectForKey("operate_createDate") as? String
        LikedButton.setTitle(nil, forState: UIControlState.Normal)
        LikedButton.setTitle(dataDict.objectForKey("praiseCount") as? String, forState: UIControlState.Selected)
    
        let isMarked = (dataDict.objectForKey("isPraise") as! String).toInt()
        if Bool(isMarked!)
        {
            LikedButton.selected = true
        }
        else
        {
            LikedButton.selected = false
        }
        
    }
    
    func likeReply()
    {
        var parameters : NSDictionary = ["replyId":self.tag,"sessionId":sessionId]
        DataClient().postLikeTopicReply(parameters) { (data, error) -> () in
            dispatch_sync(dispatch_get_main_queue(), { () -> Void in
                self.likeReplyCompleted(data,error: error)
                
            })
        }
    }
    
    func likeReplyCompleted(data:NSDictionary?,error:NSError?)
    {
        if data?.objectForKey("errcode") as? Int == 0
        {
            let count = LikedButton.titleLabel!.text!.toInt()! + 1
            LikedButton.setTitle(String(count), forState: UIControlState.Selected)
            LikedButton.selected = true
        }
        
        
    }

}
